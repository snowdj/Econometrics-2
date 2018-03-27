#=
    Illustrates MSM (indirect inference version) by fitting a simple SV model
    using a HAR auxiliary model
=#

# to run in parallel, do export JULIA_NUM_THREADS=x
# where x is the number of cores you'd like to use

using StatPlots

# the d.g.p.
function SVmodel(n, θ = 0.0, randdraws = 0.0)
    # draw parameter from parameter space, if not provided
    if θ==0.0
        # sample from uniform over box
        lb = [0.01, 0.0, 0.01]
        ub = [1.0, 0.99, 1.0]
        θ = (ub-lb).*rand(3) + lb
    end
    α = θ[1]
    ρ = θ[2]
    σᵤ = θ[3]
    burnin = 1000
    ys = zeros(n)
    hlag = 0.0
    # generate shocks if not provided
    if randdraws == 0.0
        randdraws = randn(burnin+n,2)
    end
    @inbounds for t = 1:burnin+n
        h = ρ*hlag + σᵤ*randdraws[t,1] # log variance follows AR(1)
        y = α*exp(h/2.0)*randdraws[t,2]
        if t > burnin
            ys[t-burnin] = y
        end
        hlag = h
    end
    σ = α*exp(hlag/2.0)
    return θ, ys, σ
end

# auxiliary model: HAR-RV(p)
# Corsi, Fulvio. "A simple approximate long-memory model
# of realized volatility." Journal of Financial Econometrics 7,
# no. 2 (2009): 174-196.
function HAR(y,p)
    #RV = log.(0.00001 .+ y.^2.0)
    RV = abs.(y)
    RVlags = lags(RV,p)
    X = [ones(size(y,1)) RVlags]
    # drop missings
    RV = RV[p+1:end]
    X = X[p+1:end,:]
    βhat = X\RV
    uhat = RV-X*βhat
    σhat = std(uhat)
    b1 = βhat[1]
    b2 = βhat[2]
    b3 = mean(βhat[2:end])
    # just keep the constant, first AR coef., and the
    # average of the lag coeffients
    return vcat(b1, b2, b3,σhat)
end

function II_moments(θ, y, randdraws)
    S = size(randdraws,1)
    n = size(y,1)
    p = 8 # number of lags for HAR model
    ϕhat = HAR(y,p) # this is being re-computed many times, needlessly, but I'm lazy
    ϕhatS = zeros(S, size(ϕhat,1))
    @inbounds Threads.@threads for s = 1:S
        junk, yₛ, junk = SVmodel(n, θ, randdraws[s,:,:])
        ϕhatS[s,:] = HAR(yₛ,p)
    end
    ms = sqrt(n)*(ϕhat' .- ϕhatS)
    W = inv(cov(ms))
    m = mean(ms,1)
    return  m, W # the moments, in a SxG matrix
end

function II_obj(θ, y, randdraws)
    m, W = II_moments(θ, y, randdraws)
    return ((m*W*m')[1,1])
end

function MSM_moments(θ, y, randdraws)
    # define a few simple momments which hopefully will identify
    # this is often standard practice when doing MSM
    # note that there's nothing to identify ρ here
    S = size(randdraws,1)
    n = size(y,1)
    m = [y y.^2 y.^3 y.^4]
    @inbounds Threads.@threads for s = 1:S
        junk, y, junk = SVmodel(n, θ, randdraws[s,:,:])
        m -= [y y.^2.0 y.^3.0 y.^4.0]/S
    end
    return m
end

function main()
# generate the sample
θₒ  = [exp(-0.736/2.0), 0.95, 0.2] # true parameter values
n = 1000 # sample size
junk, y, σ = SVmodel(n, θₒ) # generate the sample
plot(y)
density(y)
# now to estimation by MSM
S = 100 # number of simulation reps
randdraws = randn(S,n+1000,2) # fix the shocks to control "chatter" (includes the burnin period)

# Estimation by indirect inference
# the auxiliary model is known to be reasonable for
# this sort of data, and thus, should identify the parameters
obj = θ -> II_obj(θ, y, randdraws)
lb = [0.01, 0.0, 0.01]
ub = [1.0, 0.99, 1.0]
# impose the parameter space bounds for positive variance and stationarity
θhat, objvalue, convergence = fmincon(obj, θₒ, [],[],lb, ub)
println("Indirect Inference results")
prettyprint([θₒ θhat], ["true" "estimated"])
println("obj. value: ", objvalue)

# Estimation by MSM (CUE) using ad hoc moments
# these moments were chosen without too much thought, and may not identify
# the parameters. This illustrates the danger of simply plugging in some
# simple sample moments and hoping for the best
moments = θ -> MSM_moments(θ, y, randdraws)
gmmresults(moments, θhat, "", "GMM example, CUE");
end
main()

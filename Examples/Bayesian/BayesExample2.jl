# Example of Bayesian estimation by MCMC
# sampling from exponential(theta) distribution
# lognormal prior

# play with n, and observe how posterior quantiles narrow
# IMPPORTANT: you need to reduce tuning when n increases,
# try to keep the acceptance rate around 40% or so.

using Distributions, Econometrics, Plots
pyplot()

function main()
	n = 30    # sample size
	truetheta = 3 # true theta
    y = rand(Exponential(truetheta), n) # sample from exponential(theta)

	chainlength = 100000
    burnin = 1000
	theta = 2.8     # start value for theta
	tuning = 0.25    # tunes the acceptance rate. Lowering increases acceptance 
                    # try to get acceptance rate to be about 0.25 or so
    chain = makechain(theta, chainlength, burnin, tuning, y)
	thetas = chain[:,1]    
    plot(thetas[end-1000:end],show=true)
    #savefig("chain.svg")
    x, d = npdensity(thetas)
    plot(x,d, show=true)
    #savefig("posterior.svg")
	dstats(chain)
end

# the prior is lognormal(1,1)
function prior(theta)
    d = LogNormal(1.0,1.0)
    p = pdf.(d, theta)
end

# the log likelihood function
function likelihood(y, theta)
    d = Exponential(theta)
    logdens = sum(logpdf.(d, y))
end

# the proposal density: random walk lognormal)
function prop_dens(trial, theta, tuning)
    d = LogNormal(log(theta), tuning)
	den = pdf(d, trial)
end

# the proposal: random walk lognormal
function proposal(theta, tuning)
    d = LogNormal(log(theta), tuning)
	trial = rand(d)
end

function makechain(theta, reps, burnin, tuning, data)
    Lcurrent = likelihood(data, theta)
    chain = zeros(reps, size(theta,1) + 1)
    for rep = 1:reps+burnin
        trial = proposal(theta, tuning)
        Ltrial = likelihood(data, trial)
        accept = 0
        # MH accept/reject (simple form for symmetric proposal)
        if rand() < (
                    exp(Ltrial-Lcurrent) * 
                    prior(trial)/prior(theta)*
                    prop_dens(theta, trial, tuning) / prop_dens(trial, theta, tuning)
                    )
            theta = trial
            Lcurrent = Ltrial
            accept = 1
        end
        if rep > burnin
            chain[rep-burnin,:] = [theta accept]
        end    
    end
    return chain
end

main()

include("DSGEmoments.jl")
include("DSGEmodel.jl") # defines prior and log-likelihood
function main()
    data = readdlm("dsgedata.txt")
    tuning = [0.0004, 0.001, 0.001, 0.15, 0.1, 0.006, 0.15, 0.004, 0.005] # fix this somehow
    include("parameters.jl")
    lb = lb_param_ub[:,1]
    ub = lb_param_ub[:,3]
    θtrue = lb_param_ub[:,2]
    θinit = (ub + lb) / 2.0 # prior mean to start
    lnL = θ -> logL(θ, data)
    Prior = θ -> prior(θ) # uniform, doesn't matter 
    # define things for MCMC
    verbosity = true
    burnin = 10000
    ChainLength = 10000
    # initial proposal moves one at a time
    Proposal = θ -> proposal1(θ, tuning)
    tuning = 0.5*[0.0003, 0.001, 0.001, 0.15, 0.01, 0.006, 0.05, 0.004, 0.005]
    chain = mcmc(θinit, ChainLength, burnin, Prior, lnL, Proposal, verbosity)
    # now use a MVN random walk proposal 
    Σ = NeweyWest(chain[:,1:9])
    tuning = 0.04
    for j = 1:10
        P = chol(Σ)
        Proposal = θ -> proposal2(θ,tuning*P)
        θinit = vec(mean(chain[:,1:9],1))
        if j == 10
            ChainLength = 100000
        end    
        chain = mcmc(θinit, ChainLength, 0, Prior, lnL, Proposal, verbosity)
        Σ = 0.5*Σ + 0.5*NeweyWest(chain[:,1:9])
        accept = mean(chain[:,end])
        #println("tuning: ", tuning, "  acceptance rate: ", accept)
        if accept > 0.35
            tuning *= 1.2
        elseif accept < 0.25
            tuning *= 0.8
        end
    end
    # keep every 10th to reduce autocorrelation
    i = 1:size(chain,1)
    j = mod.(i,10.0).==0
    chain = chain[j,:] 
    
    # plain MCMC fit
    posmean = vec(mean(chain[:,1:9],1))
    inci = zeros(9)
    for i = 1:9
        lower = quantile(chain[:,i],0.05)
        upper = quantile(chain[:,i],0.95)
        inci[i] = θtrue[i] >= lower && θtrue[i] <= upper
    end
    prettyprint([posmean inci])
    return chain
end
main();

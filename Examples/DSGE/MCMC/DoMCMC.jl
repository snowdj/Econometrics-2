include("DSGEmoments.jl")
include("DSGEmodel.jl") # defines prior and log-likelihood
function main()
    data = readdlm("dsgedata.txt")
    ChainLength = 50000
    burnin = 20000
    chain = 0.0 # initialize outside loop
    tuning = [0.0004, 0.001, 0.001, 0.15, 0.1, 0.006, 0.15, 0.004, 0.005] # fix this somehow
    include("parameters.jl")
    lb = lb_param_ub[:,1]
    ub = lb_param_ub[:,3]
    θtrue = lb_param_ub[:,2]
    # fix this next for this DGP
    θinit = (ub + lb) / 2.0 # prior mean to start
    # define things for MCMC
    lnL = θ -> logL(θ, data)
    Proposal = θ -> proposal1(θ, tuning)
    Prior = θ -> prior(θ) # uniform, doesn't matter 
    chain = mcmc(θinit, ChainLength, burnin, Prior, lnL, Proposal)
    Σ = NeweyWest(chain[:,1:9])
    prettyprint(Σ)
    P = chol(Σ)
    tuning = 0.05
    Proposal = θ -> proposal2(θ,tuning*P)
    θinit = vec(mean(chain[:,1:9],1))
    chain = mcmc(θinit, ChainLength, burnin, Prior, lnL, Proposal)
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

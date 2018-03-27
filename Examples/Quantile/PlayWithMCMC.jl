#= 
learn a bit more about MCMC. This explores using
a proposal density that takes into account the 
correlations of the posterior, to get better
mixing

* play with scaling to see effects on acceptance rate
* examine chains with different acceptance rates
* look at scatter plots to see posterior correlations
=#

include("QIVmodel.jl")
LNW, X, Z = getdata()
n = size(LNW,1)
mcmcreps = 100000
burnin = 100000
# use st. errs. from ordinary QR as quide to setting tuning.
basetuning = [0.1, 0.05, 0.03, 0.005, 0.3, 0.2, 0.2]
# adjust this up or down to achieve decent acceptance rate
scale = 0.1 # higher for higher taus 
tuning = scale*basetuning


τ = 0.5
Σ = τ*(1.0-τ)*Z'Z/n
Σinv = inv(Σ)
θ = X\LNW  # OLS start values
# to do ordinary QR via MCMC, set Z=X (just to verify that MCMC works!)
lnL = θ -> likelihood(θ, LNW, X, Z, τ, Σinv)
Proposal = θ -> proposal(θ, tuning)
Prior = θ -> prior(θ)
chain = mcmc(θ, mcmcreps, burnin, Prior, lnL, Proposal)
d = dstats(chain)
# explore things:
plot(chain[:,1], show=true) # chain is highly autocorrelated!
scatter(chain[:,1],chain[:,2], show=true, reuse=false) # there is significant posterior correlation
#= these results suggest that the proposal could be improved:
    * compute the covariance of the chain, and make draws from random walk MVN with that covariance
    * the following implements this idea
=#

# the following uses a different proposal, with correlations 
# across the parameters, based on the previous chain.
V = cov(chain[:,1:end-1])
cholV = chol(V)
tuning = 0.5
Proposal = θ -> proposal2(θ, tuning*cholV)
chain = mcmc(θ, mcmcreps, burnin, Prior, lnL, Proposal)
plot(chain[:,1], show=true) # chain mixes better!
scatter(chain[:,1],chain[:,2], show=true, reuse=false) # there is still significant posterior correlation, as expected


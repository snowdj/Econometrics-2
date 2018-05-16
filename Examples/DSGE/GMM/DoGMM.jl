# this computes the GMM estimator by SA minimization, for
# each of the 1000 data sets. Can be parallelized using
# threads.
function main()
include("DSGEmoments.jl")  # computes errors
include("parameters.jl") # load true parameter values
data = readdlm("dsgedata.txt")
# estimate by simulated annealing
lb = lb_param_ub[:,1]
ub = lb_param_ub[:,3]
# define CUE GMM criterion
moments = theta -> DSGEmoments(theta, data)
m = theta -> vec(mean(moments(theta),1)) # 1Xg
momentcontrib = theta -> moments(theta) # nXg
weight = theta -> inv(NeweyWest(momentcontrib(theta)))
obj = theta -> m(theta)'*weight(theta)*m(theta)
thetastart = (ub+lb)/2.0 # prior mean as start
# attempt gradient based (doesn't work)
thetahat, objvalue, converged = fmincon(obj, thetastart, [], [], lb, ub; iterlim=10000)
println("fmincon results. objective fn. value: ", objvalue)
println("parameter values:")
prettyprint(thetahat)

# simulated annealing
thetahat, objvalue, converged, details = samin(obj, thetastart, lb, ub; ns = 20, verbosity = 2, rt = 0.5)
# compute the estimated standard errors and CIs
D = (Calculus.jacobian(m, vec(thetahat), :central))
W = weight(thetahat)
V = inv(D'*W*D)/(size(data,1)-2.0)
se = sqrt.(diag(V))
println("estimates, st. error, and limits of 95% CI")
prettyprint([thetahat se thetahat-1.96*se thetahat+1.96*se])

end
main()

#=
This script allows you to play around with GMM
esimation of the simple DSGE model. You can
experiment with different moments and different
start values. This should convince you that 
simply getting the GMM estimates can be quite 
difficult.

SA plus start at true values give optimized
function = 0, when exactly identified, so
there is a solution
=#

dsgedata = readdlm("dsgedata.txt")
include("GetErrors.jl")  # computes errors
include("parameters.jl") # load true parameter values
theta0 = lb_param_ub[:,2] 

function DSGEmoments(theta, data)
    e = GetErrors(theta, data)
    e[:,2] = 10.0*e[:,2]  # the other errors have variance = 1
    e[:,5] = 10.0*e[:,5]  # at the true values, this puts these
                          # two on the same scale  
    # finish selecting your moments here,
    # one way or another
    # ============ OPTION 1 ========================
    # this option gives exact identification, and works
    # (at least sometimes) if the start values are the true parameters
    m0 = [e 10.0*(e[:,1].^2.0 - 1.0) e[:,3].^2.0-1.0 e[:,4].^2.0 - 1.0] # dim is 8 at this point
    m = [m0 10.0*(m0[:,1].*m0[:,2])]
    # ============ END OPTION 1 ====================

    # ============ OPTION 2 ========================
    # this option is overidentifying, crossing 
    # errors with variables, in the typical way
    #=
    m0 = [e 10.0*(e[:,1].^2.0 - 1.0) e[:,3].^2.0-1.0 e[:,4].^2.0 - 1.0] # dim is 8 at this point
    g0 = size(m0,2)
    k = size(data,2)
    m = zeros(size(m0,1), g0*k)
    data = data[3:end,:]
    for i = 1:k
            m[:,i*g0-g0+1:i*g0] = m0.*data[:,i]
    end
    m = [m0 m]
    =#
    return m
end
# define GMM criterion
moments = theta -> DSGEmoments(theta, dsgedata)
# average moments
m = theta -> vec(mean(moments(theta),1)) # 1Xg
# moment contributions
momentcontrib = theta -> moments(theta) # nXg
# weight
weight = theta -> inv(NeweyWest(momentcontrib(theta)))
# objective
obj = theta -> m(theta)'*weight(theta)*m(theta)
# estimate by simulated annealing
lb = lb_param_ub[:,1]
ub = lb_param_ub[:,3]
thetastart = theta0    # true values as start
#thetastart = (ub+lb)/2.0 # prior mean as start
# simulated annealing
thetahat, objvalue, converged, details = samin(obj, thetastart, lb, ub; rt = 0.75)
# attempt box constrained interior point method to refine
thetahat, objvalue, converged = fmincon(obj, thetahat, [],[], lb, ub)
println("the average moments at the estimate (should be zeros when exactly identified):")
prettyprint(m(thetahat))


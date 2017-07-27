include("FoggyMountainObj.jl")
# One BFGS run with poor starting values
theta = [8.0, -8.0]
thetahat, obj_value, converged = fminunc(FoggyMountainObj, theta)  
println()
println("The result with poor start values")
println("objective function value: ", round(obj_value,5))
println("local minimizer: ", thetahat)
println()
# Now try simulated annealing
lb = [-20.0,-20.0]
ub = -lb
xopt = samin(FoggyMountainObj, theta, lb, ub, verbosity=1)


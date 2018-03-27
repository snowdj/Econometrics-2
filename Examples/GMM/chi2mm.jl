# method of moments estimators for a sample from Chi^2(theta)
# increase n to observe consistency
# note that the two estimators are different from one another
using Distributions
n = 30
theta = 3
y = rand(Chisq(theta), n)
thetahat = mean(y)
println("mm estimator based on mean: ", thetahat)

thetahat = 0.5*var(y)
println("mm estimator based on variance: ", thetahat)


# GMM estimation for a sample from Chi^2(theta)
# compare to two method of moments estimators (see chi2mm.m)
using Distributions, Plots
pyplot()
n = 30
theta = 3
reps = 1000
results = zeros(reps,2)
for i = 1:1000
    y = rand(Chisq(theta), n)
    moments = theta -> [theta.-y  theta.-0.5.*(y .- mean(y)).^2.0]
    thetahat, junk, junk, ms, junk = gmm(moments, [3.0], eye(2))
    results[i,1] = sqrt(n)*(thetahat[1]-theta)
    W = inv(cov(ms))
    thetahat, junk, ms, junk = gmm(moments, thetahat, W)
    results[i,2] = sqrt(n)*(thetahat[1]-theta)
end    
histogram(results[:,1],nbins=50)
#savefig("Inefficient.svg")
histogram(results[:,2],nbins=50)
#savefig("Efficient.svg")
println("Monte Carlo covariance: (1,1) is inefficient GMM, (2,2) is efficient")
prettyprint(cov(results));

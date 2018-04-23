# this is a little Monte Carlo exercise that illustrates that
# the OLS estimator is biased and inconsistent when errors are
# correlated with regressors, but that the IV estimator is consistent
using Plots
pyplot()
reps = 1000 # number of Monte Carlo reps.
betaols = zeros(reps,2)
betaiv = zeros(reps,2)
n = 1000 # sample size

# covariance of X, W, e
cov_X_W = 1.0  # experiment with lowering or raising this: quality of instrument
cov_X_e = 0.5
sig = [
      3.0       cov_X_W     cov_X_e;
      cov_X_W   1.0         0.0;
     cov_X_e    0.0         1.0];

truebeta = [1, 2] # true beta
p = chol(sig);
for i = 1:reps
	XWE = randn(n,3)*p
	e = XWE[:,3]
	w = [ones(n,1)  XWE[:,2]]
	x = [ones(n,1) XWE[:,1]]
	y = x*truebeta + e
	# OLS
	betaols[i,:] = y\x
	# IV
	betaiv[i,:] = inv(w'*x)*w'*y
end

histogram(betaols[:,2], nbins=50)
#savefig("ols.svg")
histogram(betaiv[:,2], nbins=50)
#savefig("iv.svg")

println("true betas are ", truebeta)
println("OLS results")
dstats(betaols)
println("IV results")
dstats(betaiv)

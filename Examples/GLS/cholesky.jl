# this illustrates the Cholesky decomposition

# create a random p.d. covariance matrix
V = randn(3,3)
V = V'*V # make it pos. def.
println("true covariance matrix")
prettyprint(V)

# take Cholesky decomp.
P = chol(V)
println("P=chol(V): P'P-V")
prettyprint(P'*P - V)

# how to sample from N(0,V)
e = randn(1000,3)*P
println("sample covariance matrix of 1000 draws from N(0,V)")
prettyprint(cov(e))

# verify that GLS transformation works
P = chol(inv(V))
println("P=chol(inv(V)): P*V*P'")
prettyprint(P*V*P')
e = e*P'
println("sample covariance matrix of transformed errors")
prettyprint(cov(e))




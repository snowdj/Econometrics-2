# this generates data from the simple supply-demand model
# q = a1 + a2*p + a3*m + e1
# q = b1 + b2*p +        e2

function main()
# number of obsn
n = 1000
# model parameters
α1 = 100.0
α2 = -1.0
α3 = 1.0
β1 = 20.0
β2 = 1.0
# exog var income
m = randn(n,5)
m = sum(m.*m,2) # chi square df=5
# structural shocks
ϵ1 = 2.0*randn(n)
ϵ2 = 2.0*randn(n)
# rf shocks
ν1 = (β2*ϵ1-α2*ϵ2)/(β2-α2)
ν2 = (ϵ1-ϵ2)/(β2-α2)
# rf coefs
π11 = (β2*α1-α2*β1)/(β2-α2)
π21 = β2*α3/(β2-α2)
π12 = (α1-β1)/(β2-α2)
π22 = α3/(β2-α2)
# sf variables
q = π11 + π21*m + ν1
p = π12 + π22*m + ν2
data = [q p m]
writedlm("data.txt", data)
end
main()

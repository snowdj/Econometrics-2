using StatPlots
# weekly close price of NSYE, data provided with GRETL
data = readdlm("nysewk.txt")
# compute weekly percentage growth
y = 100.0 * log.(data[2:end] ./ data[1:end-1])
plot(y, leg=false, show=true)
#savefig("nyse.svg")
histogram(y, normed=true)
plot!(Distributions.Normal(mean(y),std(y)), show=true, leg=false)
#savefig("nysefreq.svg")
display(npdensity(y))
savefig("density.svg")

#=
This shows some data wrangling using the Card data
on returns to education
=#

##
using DataFrames, DataFramesMeta
card = readtable("../Data/card.csv")
# or
card = CSV.read("../Data/card.csv")
head(card)


##
# add some variables
card[:lnwage] = round(log.(card[:wage]),4) # round to save storage space
card[:expsq] = (card[:exper].^2)/100
card[:agesq] = card[:age].^2

##
# select the ones we want
cooked = @select(card, :lnwage, :educ, :exper, :expsq, :black, :south, :smsa, :age, :agesq, :nearc4 )
head(cooked)

##
# write as CSV
using CSV
CSV.write("cooked.csv", cooked)

##
# write as plain ASCII
data = convert(Array{Float64}, cooked)
writedlm("cooked.txt", data)

# for binary write, see JLD.jl and Feather.jl

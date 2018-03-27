#=
This shows basic data analysis using the Card data
on returns to education

See the github pages of the packages for documentation

=#

##
using DataFrames, DataFramesMeta
card = readtable("../Data/card.csv") # how to read CSV data into DataFrame
size(card)
names(card)
head(card)
describe(card)

##
# select south and black (using DataFramesMeta)
sb = @where(card, :south .== 1, :black .== 1)
# make a scatter plot
using StatPlots
@df sb scatter(:educ, :wage, leg=false)
# select north and white
nw = @where(card, :south .== 0, :black .== 0)
@df nw scatter!(:educ, :wage, leg=false)
##
# do the same thing using the all the data, with grouping
@df card scatter(:educ, :wage, group = (:black, :south), markersize=10)
##
# density plots by groups
@df card density(:wage, group=(:black), fill=true, fillalpha=0.3, legend=false)

##
# violin and box plots
@df card violin(:wage)
@df card boxplot!(:wage) # puts is beside
# violin plot of wage, by education
@df card violin(:educ, :wage)
# add a boxplot on top
@df card boxplot!(:educ, :wage)
##
# convert the dataframe to an ordinary array,
# as this is usually better for more advanced
# modeling
data = convert(Array{Float64}, card)
writedlm("card.ascii", data) # write to plain ASCII file

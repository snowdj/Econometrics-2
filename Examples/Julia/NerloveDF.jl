# shows some data analysis using DataFrames
using CSV, StatsModels, DataFrames, StatPlots
nerlove = CSV.read("nerlove.csv")
nerlove[:lnC] = log.(nerlove[:cost])
nerlove[:lnQ] = log.(nerlove[:output])
nerlove[:lnPL] = log.(nerlove[:labor])
nerlove[:lnPF] = log.(nerlove[:fuel])
nerlove[:lnPK] = log.(nerlove[:capital])
show(describe(nerlove))
@df nerlove scatter(:lnC, :lnQ)
gui()
f = @formula(lnC ~ 1 + lnQ + lnPL + lnPF + lnPK)
ols(f, nerlove)

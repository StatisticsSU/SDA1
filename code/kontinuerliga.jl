using Plots, Distributions, LinearAlgebra, PlotUtils
using LaTeXStrings, StatsBase, Utils, CSV, DataFrames, Optim

figFolder = "/home/mv/Dropbox/Teaching/SDA1/slides/figs/"
dataFolder = "/home/mv/Dropbox/Teaching/SDA1/code/"
opacity = 0.3

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[2], lw = 2,
    xtickfontsize=10, ytickfontsize=14, xguidefontsize=14, 
    yguidefontsize=14, legendfontsize=10, titlefontsize = 16,
    markerstrokecolor = :auto)

# Reading and setting up data
ericsson = CSV.read(dataFolder*"Ericsson2022.csv", DataFrame)
data = ericsson[!,["Datum","Stängn.kurs"]]
rename!(data, ["Datum","Pris"])
reverse!(data)
returns = 100*diff(log.(data.Pris))

ericsson = DataFrame(datum = data.Datum[2:end], avkastning = returns)
CSV.write(dataFolder*"ericsson.csv", ericsson)

plot(data.Datum[2:end], returns, title = "Daglig % avkastning Ericsson B")
savefig(figFolder*"ericsson_timeseries.pdf")

# Fit student-t, including df
function loglike_studentt(param, x)
    μ = param[1]
    σ = exp(param[2])
    ν = exp(param[3])
    return sum(logpdf.(TDist(μ, σ, ν), x))
end

res = optimize(param -> -loglike_studentt(param, returns), [0,log(s),log(10)], 
    LBFGS(); autodiff = :forward)
param_opt = res.minimizer
param_opt_best = [param_opt[1], exp(param_opt[2]), exp(param_opt[3])]


# Fit normal
xgrid = -20:0.01:10
x̄ = mean(returns)
s = std(returns)
normpdf = pdf.(Normal(x̄, s), xgrid)
histogram(returns, normalize = true, nbins = 40, fillcolor = colors[1], lw = 0.2, 
    xlab = "% avkastning", yaxis = false, label = "Data", legend = :topleft,
    title = "Daglig % avkastning Ericsson B")
plot!(xgrid, normpdf, c = colors[2], label = "Normal")

# Plot student-t 
tpdf = pdf.(TDist(param_opt_best[1],param_opt_best[2], param_opt_best[3]), xgrid) 
plot!(xgrid, tpdf, c = colors[4], label = "Student-t")

savefig(figFolder*"ericsson_studentt.pdf")



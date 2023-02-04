using Plots, Distributions, LinearAlgebra, PlotUtils
using LaTeXStrings, StatsBase, Utils

figFolder = "/home/mv/Dropbox/Teaching/SDA1/slides/figs/"
opacity = 0.3

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[4], lw = 4,
    xtickfontsize=18, ytickfontsize=14, xguidefontsize=18, 
    yguidefontsize=18,
    legendfontsize=14, titlefontsize = 24)

# Discrete distribution
xvals = 1:5
probs = [0.1,0.25,0.4, 0.2, 0.05]
bar(xvals, probs, label = nothing, lw = 0, grid = false,
    xticks = 1:5, ylab = L"P(X=x)", xlab = L"x", c = colors[4],
    bar_width = 0.3, linecolor = :auto)
savefig(figFolder*"discrete_dist.svg")

# Normal distribution
μ = 2
σ = 3
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
plot(xgrid,normaldens, color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing, 
    ylab = L"f(x)", xlab = L"x")
savefig(figFolder*"normal.svg")

# Chi2 distribution
ν = 3
xvals = 0:0.01:12
plot(xvals, pdf.(Chisq(ν), xvals), label = nothing, lw = 2,
    ylab = L"f(x)", xlab = L"x", c = colors[10],
    fill=(0, opacity, colors[10]))
savefig(figFolder*"chi2.svg")

# Normal distribution - no axis 
μ = 2
σ = 3
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
plot(xgrid,normaldens, color=colors[2], yaxis = false, xaxis = false,
    fill=(0,opacity,colors[2]), label = nothing)
savefig(figFolder*"normal_noaxis.svg")


Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[4], lw = 4,
    xtickfontsize=16, ytickfontsize=12, xguidefontsize=16, 
    yguidefontsize=16,
    legendfontsize=12, titlefontsize = 22)

# Standard normal distribution  interval
μ = 0
σ = 1
xgrid = (μ - 3*σ):0.01:(μ + 3*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff1 = -1
cutoff2 = 1
probLessThanCutOff = cdf(Normal(μ, σ), cutoff1)
plot(xgrid[xgrid.>=cutoff1 .&& xgrid.<=cutoff2],
    normaldens[xgrid.>=cutoff1 .&& xgrid.<=cutoff2], 
    color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing, yaxis = false,
    title = L"68.3\%: \mu \pm \sigma")

plot!(xgrid, normaldens, color = colors[2], label = nothing,
    xlabel = L"x")

savefig(figFolder*"standard_normal_1std.pdf")

μ = 0
σ = 1
xgrid = (μ - 3*σ):0.01:(μ + 3*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff1 = -2
cutoff2 = 2
probLessThanCutOff = cdf(Normal(μ, σ), cutoff1)
plot(xgrid[xgrid.>=cutoff1 .&& xgrid.<=cutoff2],
    normaldens[xgrid.>=cutoff1 .&& xgrid.<=cutoff2], 
    color=colors[4],
    fill=(0,opacity,colors[4]), label = nothing, yaxis = false,
    title = L"95.4\%: \mu \pm 2 \sigma")

plot!(xgrid, normaldens, color = colors[4], label = nothing,
    xlabel = L"x")

savefig(figFolder*"standard_normal_2std.pdf")

μ = 0
σ = 1
xgrid = (μ - 3*σ):0.01:(μ + 3*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff1 = -3
cutoff2 = 3
probLessThanCutOff = cdf(Normal(μ, σ), cutoff1)
plot(xgrid[xgrid.>=cutoff1 .&& xgrid.<=cutoff2],
    normaldens[xgrid.>=cutoff1 .&& xgrid.<=cutoff2], 
    color=colors[10],
    fill=(0,opacity,colors[10]), label = nothing, yaxis = false,
    title = L"99.7\%: \mu \pm 3 \sigma")

plot!(xgrid, normaldens, color = colors[10], label = nothing,
    xlabel = L"x")

savefig(figFolder*"standard_normal_3std.pdf")




# Median and interquartile range - Normal distribution
μ = 2
σ = 3
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
plot(xgrid,normaldens, color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing, 
    ylab = L"f(x)", xlab = L"x")
savefig(figFolder*"normal.svg")

# Chi2 distribution
ν = 3
xvals = 0:0.01:12
plot(xvals, pdf.(Chisq(ν), xvals), label = nothing, lw = 2,
    ylab = L"f(x)", xlab = L"x", c = colors[10],
    fill=(0, opacity, colors[10]))
savefig(figFolder*"chi2.svg")
# Plots for hexagons and things

using Plots, Distributions, LinearAlgebra, PlotUtils, StatsBase
using LaTeXStrings, Measures, StatsPlots
figFolder = "/home/mv/Dropbox/Teaching/SDA1/misc/hexagons/figs/"

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[2], lw = 4,
    xtickfontsize=18, ytickfontsize=14, xguidefontsize=18, 
    yguidefontsize=18,
    legendfontsize=14, titlefontsize = 24)

# Standard Normal distribution
xgrid = -4:0.01:4
normaldens = pdf.(Normal(), xgrid)
cutoff = 1
probLessThanCutOff = cdf(Normal(), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing, yaxis = false,
    xticks = [], xaxis = false,
    background_color=:transparent, foreground_color=:black)

plot!(xgrid, normaldens, color = colors[2], label = nothing)

#annotate!(cutoff +0.1, -0.037, 
    text(L"z", :black, :right, 26))
#annotate!(-2, 0.2, 
    text(L"P(Z\leq z)", :black, :right, 20))
#plot!([-1.95,0], [0.195,0.1], arrow = true, lw = 2, color = :black)
savefig(figFolder*"standard_normal_tranparent.svg")

x = -1:0.1:1
y = 1 .+ x .+ 0.2*rand(Normal(),length(x))
scatter(x, y, c = colors[1], markerstrokecolor = :auto, 
    xaxis = false, yaxis = false, markersize = 10, 
    background_color=:transparent, foreground_color=:black)
#xl, yl = xlims(p), ylims(p)
#annotate!(xl[2],yl[1], text('\u27A4',7,:black,rotation=0))
#annotate!(xl[1],yl[2], text('\u27A4',7,:black,rotation=90))
savefig(figFolder*"regression.svg")

boxplot(size = (100,400), repeat([1],outer=100),rand(TDist(10),100), 
    xaxis = false, yaxis = false, lw = 2, c = colors[2],
    markerstrokecolor = :auto, markersize = 6,
    background_color=:transparent, foreground_color=:black)
savefig(figFolder*"boxplot.svg")

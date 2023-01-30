using Plots, Distributions, LinearAlgebra, PlotUtils
using LaTeXStrings, StatsBase, Utils

figFolder = "/home/mv/Dropbox/Teaching/SDA1/slides/figs/"

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[2], lw = 4,
    xtickfontsize=18, ytickfontsize=14, xguidefontsize=18, 
    yguidefontsize=18,
    legendfontsize=14, titlefontsize = 24)
    
# Discrete distribution
xvals = 1:5
probs = [0.1,0.25,0.4, 0.2, 0.05]
bar(xvals, probs, label = nothing, lw = 0, grid = false,
    xticks = 1:5, ylab = L"P(X=x)", xlab = L"x", c = colors[2],
    bar_width = 0.3, linecolor = :auto)
savefig(figFolder*"discrete_dist.svg")
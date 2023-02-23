using Pkg
Pkg.activate(".")
using Plots, Distributions, LinearAlgebra, PlotUtils, StatsBase
using LaTeXStrings, Measures, Utils
figFolder = "/home/mv/Dropbox/Teaching/SDA1/slides/figs/"

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[2], lw = 4,
    xtickfontsize=20, ytickfontsize=14, xguidefontsize=18, 
    yguidefontsize=18,
    legendfontsize=14, titlefontsize = 24)
opacity = 0.5


# Student-t distribution - two tailed, but showing complements
xgrid = -4:0.01:4
tdens = pdf.(TDist(4), xgrid)
cutoff1 = -2
cutoff2 = 2
plot(xgrid[xgrid.>=cutoff2],tdens[xgrid.>=cutoff2], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing, yaxis = false,
    xticks = ([0,cutoff2],[0,L"t_{0.025}"]), title = "Tvåsidigt", margins = 5mm)

plot!(xgrid, tdens, color = colors[2], label = nothing)
plot!(xgrid[xgrid.<=cutoff2],tdens[xgrid.<=cutoff2], color=colors[1],
    fill=(0,0.1,colors[2]), label = nothing)

plot!(xgrid, tdens, color = colors[2], label = nothing)

#annotate!(cutoff2 +0.8, -0.05, 
#    text(L"t_{0.025}", :black, :right, 28))
annotate!(3.9, 0.09, 
    text(L"0.025", :black, :right, 26))
plot!([3.1, 2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

annotate!(-1.8, 0.23, 
    text(L"0.975", :black, :right, 26))
plot!([-2.3, 0], [0.205, 0.1], arrow = true, lw = 2, color = :black)

savefig(figFolder*"standard_t_twotails_complements.svg")
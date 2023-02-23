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

# Standard normal distribution - two tailed - general
xgrid = -4:0.01:4
tdens = pdf.(Normal(), xgrid)
cutoff1 = -2
cutoff2 = 2
plot(xgrid[xgrid.>=cutoff2],tdens[xgrid.>=cutoff2], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing, yaxis = false,
    xticks = [0], title = L"1-\alpha"*" intervall", margins = 5mm)

plot!(xgrid, tdens, color = colors[2], label = nothing)
plot!(xgrid[xgrid.<=cutoff1],tdens[xgrid.<=cutoff1], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing)

plot!(xgrid, tdens, color = colors[2], label = nothing)

annotate!(cutoff1 +0.8, -0.05, 
    text(L"-z_{\alpha/2}", :black, :right, 28))
annotate!(-2.8, 0.09, 
    text(L"\alpha/2", :black, :right, 26))
plot!([-3.1,-2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

annotate!(cutoff2 +0.8, -0.05, 
    text(L"z_{\alpha/2}", :black, :right, 28))
annotate!(3.9, 0.09, 
    text(L"\alpha/2", :black, :right, 26))
plot!([3.1, 2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

annotate!(0, 0.2, 
    text(L"1-\alpha", :black, :middle, 26))

savefig(figFolder*"standard_normal_twotails.pdf")


# Standard normal distribution - two tailed - 95% intervals
xgrid = -4:0.01:4
tdens = pdf.(Normal(), xgrid)
cutoff1 = -1.96
cutoff2 = 1.96
plot(xgrid[xgrid.>=cutoff2],tdens[xgrid.>=cutoff2], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing, yaxis = false,
    xticks = [0], title = "95%-igt intervall: "*L"z_{0.025}=1.96", margins = 5mm)

plot!(xgrid, tdens, color = colors[2], label = nothing)
plot!(xgrid[xgrid.<=cutoff1],tdens[xgrid.<=cutoff1], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing)

plot!(xgrid, tdens, color = colors[2], label = nothing)

annotate!(cutoff1 +0.8, -0.05, 
    text(L"-z_{0.025}", :black, :right, 28))
annotate!(-2.8, 0.09, 
    text(L"0.025", :black, :right, 26))
plot!([-3.1,-2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

annotate!(cutoff2 +0.8, -0.05, 
    text(L"z_{0.025}", :black, :right, 28))
annotate!(3.9, 0.09, 
    text(L"0.025", :black, :right, 26))
plot!([3.1, 2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

annotate!(0, 0.2, 
    text(L"0.95", :black, :middle, 26))

savefig(figFolder*"standard_normal_twotails_95.pdf")


# Standard normal distribution - two tailed - 80% intervals
xgrid = -4:0.01:4
tdens = pdf.(Normal(), xgrid)
cutoff1 = -1.282
cutoff2 = 1.282
plot(xgrid[xgrid.>=cutoff2],tdens[xgrid.>=cutoff2], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing, yaxis = false,
    xticks = [0], title = "80%-igt intervall: "*L"z_{0.1}=1.282", margins = 5mm)

plot!(xgrid, tdens, color = colors[2], label = nothing)
plot!(xgrid[xgrid.<=cutoff1],tdens[xgrid.<=cutoff1], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing)

plot!(xgrid, tdens, color = colors[2], label = nothing)

annotate!(cutoff1 +0.8, -0.05, 
    text(L"-z_{0.1}", :black, :right, 28))
annotate!(-2.8, 0.09, 
    text(L"0.1", :black, :right, 26))
plot!([-3.1,-2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

annotate!(cutoff2 +0.8, -0.05, 
    text(L"z_{0.1}", :black, :right, 28))
annotate!(3.9, 0.09, 
    text(L"0.1", :black, :right, 26))
plot!([3.1, 2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

annotate!(0, 0.2, 
    text(L"0.80", :black, :middle, 26))

savefig(figFolder*"standard_normal_twotails_80.pdf")


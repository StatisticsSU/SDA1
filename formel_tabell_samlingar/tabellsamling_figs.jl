using Pkg
Pkg.activate(".")
using Plots, Distributions, LinearAlgebra, PlotUtils, StatsBase
using LaTeXStrings, Measures, Utils
figFolder = "/home/mv/Dropbox/Teaching/SDA1/formel_tabell_samlingar/figs/"

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[2], lw = 4,
    xtickfontsize=20, ytickfontsize=14, xguidefontsize=18, 
    yguidefontsize=18,
    legendfontsize=14, titlefontsize = 24)
opacity = 0.5

# Standard Normal distribution
xgrid = -4:0.01:4
normaldens = pdf.(Normal(), xgrid)
cutoff = 1.6
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[6],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    xticks = [0], xtickfontsize=22)
plot!(xgrid, normaldens, color = colors[6], label = nothing)

annotate!(cutoff +0.19, -0.038, text(L"z", :black, :right, 36))
savefig(figFolder*"standard_normal_tabell.svg")

# Standard Normal distribution - symmetry
xgrid = -4:0.01:4
normaldens = pdf.(Normal(), xgrid)
cutoff = -1.6
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[6],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    xticks = [0], xtickfontsize=22, title = "Symmetri")
plot!(xgrid[xgrid.>=abs(cutoff)],normaldens[xgrid.>=abs(cutoff)], color=colors[6],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    xticks = [0], xtickfontsize=22)
plot!(xgrid, normaldens, color = colors[6], label = nothing)

annotate!(cutoff +0.19, -0.038, text(L"-z", :black, :right, 36))
annotate!(abs(cutoff) +0.19, -0.038, text(L"z", :black, :right, 36))

savefig(figFolder*"standard_normal_tabell_symmetry.svg")

# Student-t distribution - one tailed
xgrid = -4:0.01:4
tdens = pdf.(TDist(4), xgrid)
cutoff = 2
plot(xgrid[xgrid.>=cutoff],tdens[xgrid.>=cutoff], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing, yaxis = false,
    xticks = [0], title = "Ensidigt", margins = 5mm)

plot!(xgrid, tdens, color = colors[2], label = nothing)

annotate!(cutoff + 0.5, -0.05, 
    text(L"t_\alpha", :black, :right, 28))
annotate!(3.6, 0.08, 
    text(L"\alpha", :black, :right, 26))
plot!([3.2,2.5], [0.06,0.015], arrow = true, lw = 2, color = :black)
savefig(figFolder*"standard_t_onetail_tabell.svg")

# Student-t distribution - two tailed
xgrid = -4:0.01:4
tdens = pdf.(TDist(4), xgrid)
cutoff1 = -2
cutoff2 = 2
plot(xgrid[xgrid.>=cutoff2],tdens[xgrid.>=cutoff2], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing, yaxis = false,
    xticks = [0], title = "Tvåsidigt", margins = 5mm)

plot!(xgrid, tdens, color = colors[2], label = nothing)
plot!(xgrid[xgrid.<=cutoff1],tdens[xgrid.<=cutoff1], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing)

plot!(xgrid, tdens, color = colors[2], label = nothing)

annotate!(cutoff1 +0.8, -0.05, 
    text(L"-t_{\alpha/2}", :black, :right, 28))
annotate!(-2.8, 0.09, 
    text(L"\alpha/2", :black, :right, 26))
plot!([-3.1,-2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

annotate!(cutoff2 +0.8, -0.05, 
    text(L"t_{\alpha/2}", :black, :right, 28))
annotate!(3.9, 0.09, 
    text(L"\alpha/2", :black, :right, 26))
plot!([3.1, 2.5], [0.055,0.015], arrow = true, lw = 2, color = :black)

savefig(figFolder*"standard_t_twotails_tabell.svg")

# Chi2 distribution
ν = 5
cutoff = 10
xgrid = 0:0.001:18
chi2dens = pdf.(Chisq(ν), xgrid)
plot(xgrid[xgrid.>=cutoff], chi2dens[xgrid.>=cutoff], label = nothing, lw = 3,
    ylab = "", yticks = [], xticks =[], xlab = "", c = colors[10],
    fill=(0, opacity, colors[10]), margins = 10mm)
plot!(xgrid, chi2dens, label = nothing, lw = 3,
    c = colors[10])

annotate!(-0.15, -0.018, 
    text(L"0", :black, :right, 26))
annotate!(cutoff + 0.9, -0.018, 
    text(L"\chi^2_\alpha", :black, :right, 26))
annotate!(cutoff + 3.9, 0.038, 
    text(L"\alpha", :black, :right, 22))
plot!([cutoff + 3.3, cutoff + 1.3], [0.03,0.007], arrow = true, lw = 2, color = :black)
savefig(figFolder*"chi2_tabell.svg")


# F distribution
ν₁ = 20
ν₂ = 2
cutoff = quantile(FDist(ν₁,ν₂), 0.8)
xgrid = 0:0.001:12
Fdens = pdf.(FDist(ν₁,ν₂), xgrid)
plot(xgrid[xgrid.>=cutoff], Fdens[xgrid.>=cutoff], label = nothing, lw = 3,
    ylab = "", yticks = [], xticks =[], xlab = "", c = colors[4],
    fill=(0, opacity, colors[4]), margins = 10mm)
plot!(xgrid, Fdens, label = nothing, lw = 3,
    c = colors[4])

annotate!(-0.15, -0.06, 
    text(L"0", :black, :right, 26))
annotate!(cutoff + 0.9, -0.06, 
    text(L"F_\alpha", :black, :right, 24))
annotate!(cutoff + 3, 0.09, 
    text(L"\alpha", :black, :right, 22))
plot!([cutoff + 2.5, cutoff + 1], [0.07,0.008], arrow = true, lw = 2, color = :black)
savefig(figFolder*"F_tabell.svg")
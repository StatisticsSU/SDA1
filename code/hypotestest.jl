using Pkg
Pkg.activate(".")
using Plots, Distributions, LinearAlgebra, PlotUtils, StatsBase
using LaTeXStrings, Measures, Utils
figFolder = "/home/mv/Dropbox/Teaching/SDA1/slides/figs/"

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[2], lw = 4,
    xtickfontsize=20, ytickfontsize=14, xguidefontsize=18, 
    yguidefontsize=18,
    legendfontsize=14, titlefontsize = 20)
opacity = 0.5


# Confidence interval - normal distribution
α = 0.05
phat = 14/160
p₀ = 0.15
n = 160
μ = phat
σ = √(phat*(1-phat)/n)
normaldens = Normal(μ, σ)
CI = (quantile(normaldens, α/2), quantile(normaldens, 1-α/2))
xgrid = (μ - 4*σ):0.001:(μ + 4*σ)
normalpdf = pdf.(normaldens, xgrid)
plot(xgrid, normalpdf, color = colors[2], label = L"\hat p \sim N(%$(round(μ, digits = 4)),%$(round(σ, digits = 4)))", xlabel = L"\hat p", legend = :topleft)
plot!(xgrid[xgrid.>=CI[1] .&& xgrid.<=CI[2]], 
    normalpdf[xgrid.>=CI[1] .&& xgrid.<=CI[2]], lw = 0,      
     color = colors[2], fill=(0,opacity,colors[2]), label = "95% K.I.", yaxis = false,
     title = "Skattad samplingfördelning för "*L"\hat p")

plot!(xgrid, normalpdf, color = colors[2], label = nothing)
plot!([p₀,p₀], [0,8], c = colors[4], label = L"p_{\mathrm{gammal}}=0.15")
plot!([0.03,0.08], [6,4], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(0.035, 7, 
    text(L"95\%", :black, :right, 16))

savefig(figFolder*"CI_displays_normal.pdf")


# Hypothesis test - normal distribution
α = 0.05
phat = 14/160
p₀ = 0.15
n = 160
μ = p₀
σ = √(p₀*(1-p₀)/n)
normaldens = Normal(μ, σ)
CIt = (quantile(normaldens, α/2), quantile(normaldens, 1-α/2))
xgrid = (μ - 4*σ):0.001:(μ + 4*σ)
normalpdf = pdf.(normaldens, xgrid)
plot(xgrid, normalpdf, color = colors[2], label = L"\hat p \sim N(%$(round(μ, digits = 3)),%$(round(σ, digits = 3)))", xlabel = L"\hat p", legend = :topright,
 title = "Under "*L"H_0: \hat p \sim N(p_0, \sqrt{p_0 q_0/n})", yaxis = false, titlelocation = :left)
plot!(xgrid[xgrid.<=CIt[1]], 
    normalpdf[xgrid.<=CIt[1]], lw = 0,      
     color = colors[2], fill=(0,opacity,colors[2]), label = "Förkastar "*L"H_0")
plot!(xgrid[xgrid.>=CIt[2]], 
     normalpdf[xgrid.>=CIt[2]], lw = 0,      
      color = colors[2], fill=(0,opacity,colors[2]), label = nothing)

plot!(xgrid, normalpdf, color = colors[2], label = nothing)
plot!([phat,phat], [0,8], c = colors[4], label = L"\hat p"*" i stickprovet")
plot!([0.23,0.215], [2.5,0.3], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(0.25, 3.2, 
    text(L"2.5\%", :black, :right, 16))
plot!([0.215-μ, 0.23-μ], [2.5,0.3], arrow = true, lw = 2, color = :black, label = nothing)
    annotate!(0.075, 3.2, 
        text(L"2.5\%", :black, :right, 16))
savefig(figFolder*"test_displays_normal.pdf")


# Hypothesis test - normal distribution - standardized
α = 0.05
phat = 14/160
p₀ = 0.15
n = 160
μ = p₀
σ = √(p₀*(1-p₀)/n)
z = (phat - p₀)/σ
μ = 0
σ = 1
normaldens = Normal(μ, σ)
CIt = (quantile(normaldens, α/2), quantile(normaldens, 1-α/2))
xgrid = (μ - 4*σ):0.001:(μ + 4*σ)
normalpdf = pdf.(normaldens, xgrid)
plot(xgrid, normalpdf, color = colors[6], label = L"Z \sim N(0,1)", xlabel = L"z", 
    legend = :topright, title = L"z = \frac{\hat p  - p_0 }{\sqrt{p_0 q_0/n}}", 
    yaxis = false, titlelocation = :left)
plot!(xgrid[xgrid.<=CIt[1]], 
    normalpdf[xgrid.<=CIt[1]], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[6]), label = "Förkastar "*L"H_0")
plot!(xgrid[xgrid.>=CIt[2]], 
     normalpdf[xgrid.>=CIt[2]], lw = 0,      
      color = colors[6], fill=(0,opacity,colors[6]), label = nothing)

plot!(xgrid, normalpdf, color = colors[6], label = nothing)
plot!([z,z], [0,0.2], c = colors[4], label = L"z_{\mathrm{obs}}"*" i stickprovet")
plot!([3.3,2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(3.9, 0.1, text(L"2.5\%", :black, :right, 16))
plot!([-3.3, -2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(-3, 0.1, text(L"2.5\%", :black, :right, 16))
savefig(figFolder*"test_displays_normal_standardized.pdf")



# Hypothesis test - normal distribution - standardized - reject/do not reject
α = 0.05
phat = 14/160
p₀ = 0.15
n = 160
μ = p₀
σ = √(p₀*(1-p₀)/n)
z = (phat - p₀)/σ
μ = 0
σ = 1
normaldens = Normal(μ, σ)
CIt = (quantile(normaldens, α/2), quantile(normaldens, 1-α/2))
xgrid = (μ - 4*σ):0.001:(μ + 4*σ)
normalpdf = pdf.(normaldens, xgrid)
plot(xgrid, normalpdf, color = colors[6], label = nothing, xlabel = L"z", 
    legend = :topright, xticks = ([CIt[1], 0, CIt[2]],[L"-z_{\alpha/2}","0",L"z_{\alpha/2}"]), yaxis = false)
plot!(xgrid[xgrid.<=CIt[1]], 
    normalpdf[xgrid.<=CIt[1]], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[6]), label = "Förkastar "*L"H_0")
plot!(xgrid[xgrid.>=CIt[2]], 
     normalpdf[xgrid.>=CIt[2]], lw = 0,      
      color = colors[6], fill=(0,opacity,colors[6]), label = nothing)

plot!([z,z], [0,0.2], c = colors[4], label = L"z_{\mathrm{obs}}")
plot!([3.3,2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(3.9, 0.1, text(L"\alpha/2", :black, :right, 16))
plot!([-3.3, -2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(-3, 0.1, text(L"\alpha/2", :black, :right, 16))
savefig(figFolder*"test_displays_normal_standardized_critregions.pdf")


# Hypothesis test - normal distribution - standardized - reject/do not reject
α = 0.05
phat = 14/160
p₀ = 0.15
n = 160
μ = p₀
σ = √(p₀*(1-p₀)/n)
z = (phat - p₀)/σ
μ = 0
σ = 1
normaldens = Normal(μ, σ)
CIt = (quantile(normaldens, α/2), quantile(normaldens, 1-α/2))
xgrid = (μ - 4*σ):0.001:(μ + 4*σ)
normalpdf = pdf.(normaldens, xgrid)
plot(xgrid, normalpdf, color = colors[6], label = nothing, xlabel = L"z", 
    legend = :topright, xticks = ([CIt[1], 0, CIt[2]],[L"-1.96","0",L"1.96"]), yaxis = false)
plot!(xgrid[xgrid.<=CIt[1]], 
    normalpdf[xgrid.<=CIt[1]], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[6]), label = "Förkastar "*L"H_0")
plot!(xgrid[xgrid.>=CIt[2]], 
     normalpdf[xgrid.>=CIt[2]], lw = 0,      
      color = colors[6], fill=(0,opacity,colors[6]), label = nothing)

plot!([z,z], [0,0.2], c = colors[4], label = L"z_{\mathrm{obs}}")
plot!([3.3,2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(3.9, 0.1, text(L"0.025", :black, :right, 16))
plot!([-3.3, -2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(-3, 0.1, text(L"0.025", :black, :right, 16))
savefig(figFolder*"test_displays_normal_standardized_critregions_alpha005.pdf")



# Hypothesis test - normal distribution - standardized - p-value with numbers
α = 0.05
phat = 14/160
p₀ = 0.15
n = 160
μ = p₀
σ = √(p₀*(1-p₀)/n)
z = (phat - p₀)/σ
μ = 0
σ = 1
normaldens = Normal(μ, σ)
pvalue = 2*cdf(normaldens, -abs(z))
pval_crit = (-z, z)
xgrid = (μ - 4*σ):0.001:(μ + 4*σ)
normalpdf = pdf.(normaldens, xgrid)
plot(xgrid, normalpdf, color = colors[6], label = L"N(0,1)", xlabel = L"z", 
    legend = :topright, xticks = ([-abs(z), 0, abs(z)],[L"-2.214","0",L"2.214"]), 
    yaxis = false, title = "Under "*L"H_0")
plot!([z,z], [0,0.2], c = colors[4], label = L"z_{\mathrm{obs}}")
plot!(xgrid[xgrid.<=-abs(z)], normalpdf[xgrid.<=-abs(z)], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[6]), label = L"p"*"-värde")
plot!(xgrid[xgrid.>=abs(z)], normalpdf[xgrid.>=abs(z)], lw = 0,      
      color = colors[6], fill=(0,opacity,colors[6]), label = nothing)

plot!([3.3,2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(3.9, 0.1, text(L"%$(round(pvalue/2, digits = 3))", :black, :right, 16))
plot!([-3.3, -2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(-3, 0.1, text(L"%$(round(pvalue/2, digits = 3))", :black, :right, 16))
savefig(figFolder*"test_displays_normal_standardized_pvalue_numeric.pdf")

# Hypothesis test - normal distribution - standardized - p-value with numbers
α = 0.05
phat = 14/160
p₀ = 0.15
n = 160
μ = p₀
σ = √(p₀*(1-p₀)/n)
z = (phat - p₀)/σ
μ = 0
σ = 1
normaldens = Normal(μ, σ)
pvalue = 2*cdf(normaldens, -abs(z))
pval_crit = (-z, z)
xgrid = (μ - 4*σ):0.001:(μ + 4*σ)
normalpdf = pdf.(normaldens, xgrid)
plot(xgrid, normalpdf, color = colors[6], label = L"N(0,1)", xlabel = L"z", 
    legend = :topright, xticks = ([-abs(z), 0, abs(z)],[L"-z_{\mathrm{obs}}","0",L"z_{\mathrm{obs}}"]), yaxis = false, title = "Under "*L"H_0")
plot!([z,z], [0,0.2], c = colors[4], label = L"z_{\mathrm{obs}}")

plot!(xgrid[xgrid.<=-abs(z)], normalpdf[xgrid.<=-abs(z)], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[6]), label = L"p"*"-värde")
plot!(xgrid[xgrid.>=abs(z)], normalpdf[xgrid.>=abs(z)], lw = 0,      
      color = colors[6], fill=(0,opacity,colors[6]), label = nothing)

plot!([2.7,2.5], [0.2, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(3.2, 0.22, text(L"p"*"-value", :black, :right, 16))
plot!([2.5, -2.5], [0.2, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
savefig(figFolder*"test_displays_normal_standardized_pvalue_symbols.pdf")


# INTERNET SPEED

# Known variance
x = [15.77,20.5,8.26,14.37,21.09]
n = length(x)
xbar = mean(x)
σ = 5
μ₀ = 20
α = 0.05
zcrit = abs(quantile(Normal(), α/2))
KI = (xbar - zcrit*(σ/√n), xbar + zcrit*(σ/√n))
zobs = (xbar - μ₀)/(σ/√n)
pvalue = 2*cdf(Normal(), zobs)

# Estimated variance
s = std(x)
tcrit = abs(quantile(TDist(n-1), α/2))
KI = (xbar - tcrit*(s/√n), xbar + tcrit*(s/√n))
tobs = (xbar - μ₀)/(s/√n)
pvalue = 2*cdf(TDist(n-1), tobs)
μ = 0
σ = 1
tdens = TDist(n-1)
xgrid = -4:0.001:4
tpdf = pdf.(tdens, xgrid)
plot(xgrid, tpdf, title = L"T\sim t_4", label = L"t_4"*"-fördelning", legend = :topright)
plot!([tobs,tobs], [0,0.2], c = colors[4], label = L"t_{\mathrm{obs}}")
plot!(xgrid[xgrid.<=-abs(tobs)], tpdf[xgrid.<=-abs(tobs)], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[1]), label = L"p"*"-värde")
plot!(xgrid[xgrid.>=abs(tobs)], tpdf[xgrid.>=abs(tobs)], lw = 0,      
    color = colors[6], fill=(0,opacity,colors[1]), label = nothing)
plot!([3.3,2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
    annotate!(3.9, 0.1, text(L"%$(round(pvalue/2, digits = 3))", :black, :right, 16))
plot!([-3.3, -2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
     annotate!(-3, 0.1, text(L"%$(round(pvalue/2, digits = 3))", :black, :right, 16))
savefig(figFolder*"internet_t_pvalue.pdf")


# One-sided p-value
tcrit = abs(quantile(TDist(n-1), α))
pvalue = cdf(TDist(n-1), tobs)
plot(xgrid, tpdf, title = L"T\sim t_4", label = L"t_4"*"-fördelning", legend = :topright)
plot!([tobs,tobs], [0,0.2], c = colors[4], label = L"t_{\mathrm{obs}}")
plot!(xgrid[xgrid.<=-abs(tobs)], tpdf[xgrid.<=-abs(tobs)], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[1]), label = L"p"*"-värde")
plot!([-3.3, -2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(-3, 0.1, text(L"%$(round(pvalue, digits = 3))", :black, :right, 16))
savefig(figFolder*"internet_t_pvalue_onesided.pdf")


# One-sided critical value
tcrit = abs(quantile(TDist(n-1), α))
plot(xgrid, tpdf, title = L"T\sim t_4", label = L"t_4"*"-fördelning", legend = :topright)
plot!([tobs,tobs], [0,0.2], c = colors[4], label = L"t_{\mathrm{obs}}")
plot!(xgrid[xgrid.<=-abs(tcrit)], tpdf[xgrid.<=-abs(tcrit)], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[1]), label = "Förkasta "*L"H_0")
plot!([-3.3, -2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(-3, 0.1, text(L"0.05", :black, :right, 16))
savefig(figFolder*"internet_t_crit_onesided.pdf")


# One-sided critical value - symbols
tcrit = abs(quantile(TDist(n-1), α))
plot(xgrid, tpdf, title = L"T\sim t_{n-1}", label = L"t_{n-1}"*"-fördelning", 
    xticks = ([-tcrit, 0], [L"-t_{n-1,\alpha}",0]), legend = :topright)
plot!([tobs,tobs], [0,0.2], c = colors[4], label = L"t_{\mathrm{obs}}")
plot!(xgrid[xgrid.<=-abs(tcrit)], tpdf[xgrid.<=-abs(tcrit)], lw = 0,      
     color = colors[6], fill=(0,opacity,colors[1]), label = "Förkasta "*L"H_0")
plot!([-3.3, -2.5], [0.07, 0.01], arrow = true, lw = 2, color = :black, label = nothing)
annotate!(-3.4, 0.08, text(L"\alpha", :black, :right, 16))
savefig(figFolder*"internet_t_crit_onesided_symbols.pdf")
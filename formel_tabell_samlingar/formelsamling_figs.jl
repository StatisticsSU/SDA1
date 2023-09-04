using Plots, Distributions, LinearAlgebra, PlotUtils, StatsBase
using LaTeXStrings, Measures, Utils
figFolder = "/home/mv/Dropbox/Apps/ShareLaTeX/SDA1/figs/"

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[2], lw = 4,
    xtickfontsize=14, ytickfontsize=14, xguidefontsize=18, 
    yguidefontsize=18,
    legendfontsize=14, titlefontsize = 24)

opacity = 0.5

# Geometric distribution
p = 0.7
xvals = 1:5
bar(xvals, pdf.(Geometric(p), xvals), label = nothing, lw = 0,
    xticks = 1:10, ylab = L"P(X=x)", xlab = L"x", c = colors[1],
    bar_width = 0.3, linecolor = :auto)#, title = L"\mathrm{Geo}(p=0.7)")
savefig(figFolder*"geometric.svg")

# Binomial distribution
n = 10
p = 0.7
xvals = 0:10
bar(xvals, pdf.(Binomial(n,p),xvals), label = nothing, lw = 0,
    xticks = 0:10, ylab = L"P(X=x)", xlab = L"x", c = colors[5],
    bar_width = 0.5)#, title = L"\mathrm{Binom}(n=10,p=0.7)")
savefig(figFolder*"binomial.svg")

# Poisson distribution
λ = 2
xvals = 0:10
bar(xvals, pdf.(Poisson(λ),xvals), label = nothing, lw = 0,
    xticks = 0:10, ylab = L"P(X=x)", xlab = L"x", c = colors[9],
    bar_width = 0.5)#, title = L"\mathrm{Pois}(\lambda=2)")
savefig(figFolder*"poisson.svg")

# Negative binomial distribution
r = 5
p = 0.7
xvals = 0:10
bar(xvals, pdf.(NegativeBinomial(r,p), xvals), label = nothing, lw = 0,
    xticks = 0:10, ylab = L"P(X=x)", xlab = L"x", c = colors[3],
    bar_width = 0.5)#, title = L"\mathrm{Negative binomial}(r=5,p=0.7)")
savefig(figFolder*"negbin.svg")

# Hypergeometrisk
s = 40 # number of successes in population
f = 60 # number of failures in population
n = 10 # number of draws
xvals = 0:10
bar(xvals, pdf.(Hypergeometric(s, f, n), xvals), label = nothing, lw = 0,
    xticks = 0:10, ylab = L"P(X=x)", xlab = L"x", c = colors[1],
    bar_width = 0.5)
savefig(figFolder*"hypergeo.svg")


# Standard Normal distribution
xgrid = -4:0.01:4
normaldens = pdf.(Normal(), xgrid)
cutoff = 1.5
probLessThanCutOff = cdf(Normal(), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing, yaxis = false,
    xticks = [0], title = L"Z \sim \mathrm{N}(0,1)")

plot!(xgrid, normaldens, color = colors[2], label = nothing)

annotate!(cutoff +0.1, -0.033, 
    text(L"z", :black, :right, 20))
annotate!(-2, 0.2, 
    text(L"P(Z\leq z)", :black, :right, 16))
plot!([-1.95,0], [0.195,0.1], arrow = true, lw = 2, color = :black)
savefig(figFolder*"standard_normal.svg")

# Normal distribution
μ = 2
σ = 3
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff = 5
probLessThanCutOff = cdf(Normal(μ, σ), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing, yaxis = false)#,
    #title = L"\mathrm{N}(\mu=%$2,\sigma^2 = 9)")

plot!(xgrid, normaldens, color = colors[2], label = nothing,
    xlabel = L"x")

plot!([-7,1.5], [0.1,0.05], arrow = true, lw = 2, color = :black)
annotate!(-4.8, 0.107, 
    text(L"P(X\leq x)", :black, :right, 16))

savefig(figFolder*"normal.pdf")

# Standardisering Normal distribution
μ = 2
σ = 3
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff = 5
probLessThanCutOff = cdf(Normal(μ, σ), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=:orange,
    fill=(0,opacity,colors[2]), label = nothing, yaxis = false,
    title = L"X\sim \mathrm{N}(\mu=%$2,\sigma^2 = 9)")

plot!(xgrid, normaldens, color = colors[2], label = nothing,
    xlabel = L"x")

plot!([-7,1.5], [0.1,0.05], arrow = true, lw = 2, color = :black)
annotate!(-3, 0.107, 
    text(L"P(X\leq %$cutoff)="*string(round(probLessThanCutOff,sigdigits = 3)),
    :black, :right, 16))

savefig(figFolder*"normalbeforestandard.svg")

μ = 2
σ = 3
cutoff = (5 - μ)/σ
μ = 0 
σ = 1
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)

probLessThanCutOff = cdf(Normal(μ, σ), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[6],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    title = L"Z \sim \mathrm{N}(0,1)")

plot!(xgrid, normaldens, color = colors[6], label = nothing,
    xlabel = L"z")

plot!([2,0.5], [0.3,0.15], arrow = true, lw = 2, color = :black)
annotate!(4.1, 0.33, 
    text(L"P(Z\leq %$(Int(cutoff)))="*string(round(probLessThanCutOff,sigdigits = 3)),
    :black, :right, 16))

savefig(figFolder*"normalafterstandard.svg")

# Uniform distribution
a = 1
b = 3
xvals = 0:0.01:4
plot(xvals[xvals .>=a .&& xvals .<=b], pdf.(Uniform(a,b), xvals[xvals .>=a .&& xvals .<=b]), label = nothing, lw = 2,
    ylab = L"f(x)", xlab = L"x", c = colors[2],
    fill=(0, opacity, colors[2]), xticks = ([a,b], ["a","b"]),
    yticks = ([0,1/(b-a)],[L"0",L"\frac{1}{b-a}"]))
plot!(xvals, pdf.(Uniform(a,b), xvals), label = nothing, lw = 2,
    c = colors[2])
savefig(figFolder*"uniform.svg")

# Exponential distribution
λ = 1
xvals = 0:0.01:6
plot(xvals, pdf.(Exponential(λ), xvals), label = nothing, lw = 2,
    ylab = L"f(x)", xlab = L"x", c = colors[4],
    fill=(0, opacity, colors[4]))
savefig(figFolder*"exponential.svg")

# Chi2 distribution
ν = 3
xvals = 0:0.01:12
plot(xvals, pdf.(Chisq(ν), xvals), label = nothing, lw = 2,
    ylab = L"f(x)", xlab = L"x", c = colors[10],
    fill=(0, opacity, colors[10]))
savefig(figFolder*"chi2.svg")

# Student-t distribution
ν = 4
xvals = -4:0.01:4
plot(xvals, pdf.(TDist(ν), xvals), label = nothing, lw = 2,
    ylab = L"f(x)", xlab = L"x", c = colors[6],
    fill=(0, opacity, colors[6]))
savefig(figFolder*"studentt.svg")

# Gamma distribution
α = 2
β = 1
xvals = eps():0.01:8
plot(xvals, pdf.(Gamma(α, β), xvals), label = nothing, lw = 2,
    ylab = L"f(x)", xlab = L"x", c = colors[10],
    fill=(0, opacity, colors[9]))
savefig(figFolder*"gamma_scale.svg")

# Beta distribution
α = 3
β = 2
xvals = eps():0.001:1
plot(xvals, pdf.(Beta(α, β), xvals), label = nothing, lw = 2,
    ylab = L"f(x)", xlab = L"x", c = colors[6],
    fill=(0, opacity, colors[5]))
savefig(figFolder*"beta.svg")

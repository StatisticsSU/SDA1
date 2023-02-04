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



# Normal distribution - 68-95-99.7 rule
μ = 2
σ = 3
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)

# 3std
plot(xgrid[xgrid.>=(μ - 3*σ) .&& xgrid.<=(μ - 2*σ)],
    normaldens[xgrid.>=(μ - 3*σ) .&& xgrid.<=(μ - 2*σ)], color=colors[2],
    fill=(0,0.1,colors[2]), label = nothing, yaxis = false,
    xticks = ([μ - 3*σ, μ - 2*σ, μ - 1*σ,μ, μ + 1*σ, μ + 2*σ, μ + 3*σ],
              [L"\mu-3\sigma",L"\mu-2\sigma",L"\mu-\sigma",L"\mu",
                    L"\mu+\sigma",L"\mu+2\sigma",L"\mu+3\sigma"]),
    title = L"X\sim\mathrm{N}(\mu,\sigma^2)")

plot!(xgrid[xgrid.>=(μ + 2*σ) .&& xgrid.<=(μ + 3*σ)],
    normaldens[xgrid.>=(μ + 2*σ) .&& xgrid.<=(μ + 3*σ)], color=colors[2],
    fill=(0,0.1,colors[2]), label = nothing)

# 2std
plot!(xgrid[xgrid.>=(μ - 2*σ) .&& xgrid.<=(μ - 1*σ)],
    normaldens[xgrid.>=(μ - 2*σ) .&& xgrid.<=(μ - 1*σ)], color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing)

plot!(xgrid[xgrid.>=(μ + 1*σ) .&& xgrid.<=(μ + 2*σ)],
    normaldens[xgrid.>=(μ + 1*σ) .&& xgrid.<=(μ + 2*σ)], color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing)

# 1std
plot!(xgrid[xgrid.>=(μ - 1*σ) .&& xgrid.<=(μ + 1*σ)],
    normaldens[xgrid.>=(μ - 1*σ) .&& xgrid.<=(μ + 1*σ)], color=colors[2],
    fill=(0,0.5,colors[2]), label = nothing)

plot!(xgrid, normaldens, color = colors[2], label = nothing, xlabel = L"x")

annotate!(μ, 0.01, text(L"68.3\%", :white, :bold, :middle, 14))
annotate!(μ-1σ-1.4, 0.01, text(L"95.4\%", :black, :middle, 14))
annotate!(μ-2σ-4.4, 0.01, text(L"99.7\%", :black, :middle, 14))
plot!([-7,-4.6], [0.01,0.003], arrow = true, lw = 1, color = :black)


savefig(figFolder*"normal_interval_rule.pdf")


# Normal distribution Standard - 68-95-99.7 rule
μ = 0
σ = 1
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)

# 3std
plot(xgrid[xgrid.>=(μ - 3*σ) .&& xgrid.<=(μ - 2*σ)],
    normaldens[xgrid.>=(μ - 3*σ) .&& xgrid.<=(μ - 2*σ)], color=colors[6],
    fill=(0,0.1,colors[6]), label = nothing, yaxis = false,
    xticks = ([μ - 3*σ, μ - 2*σ, μ - 1*σ,μ, μ + 1*σ, μ + 2*σ, μ + 3*σ],
              [L"\mu-3\sigma",L"\mu-2\sigma",L"\mu-\sigma",L"\mu",
                    L"\mu+\sigma",L"\mu+2\sigma",L"\mu+3\sigma"]),
    title = L"Z\sim\mathrm{N}(0,1)")

plot!(xgrid[xgrid.>=(μ + 2*σ) .&& xgrid.<=(μ + 3*σ)],
    normaldens[xgrid.>=(μ + 2*σ) .&& xgrid.<=(μ + 3*σ)], color=colors[6],
    fill=(0,0.1,colors[6]), label = nothing)

# 2std
plot!(xgrid[xgrid.>=(μ - 2*σ) .&& xgrid.<=(μ - 1*σ)],
    normaldens[xgrid.>=(μ - 2*σ) .&& xgrid.<=(μ - 1*σ)], color=colors[6],
    fill=(0,opacity,colors[6]), label = nothing)

plot!(xgrid[xgrid.>=(μ + 1*σ) .&& xgrid.<=(μ + 2*σ)],
    normaldens[xgrid.>=(μ + 1*σ) .&& xgrid.<=(μ + 2*σ)], color=colors[6],
    fill=(0,opacity,colors[6]), label = nothing)

# 1std
plot!(xgrid[xgrid.>=(μ - 1*σ) .&& xgrid.<=(μ + 1*σ)],
    normaldens[xgrid.>=(μ - 1*σ) .&& xgrid.<=(μ + 1*σ)], color=colors[6],
    fill=(0,0.5,colors[6]), label = nothing)

plot!(xgrid, normaldens, color = colors[6], label = nothing, xlabel = L"z")

annotate!(μ, 0.01*3, text(L"68.3\%", :white, :bold, :middle, 14))
annotate!(μ-1σ-0.5, 0.01*3, text(L"95.4\%", :black, :middle, 14))
annotate!(μ-2σ-1.5, 0.01*3, text(L"99.7\%", :black, :middle, 14))
plot!([-3,-2.2], [0.03,0.007], arrow = true, lw = 1, color = :black)


savefig(figFolder*"normal_interval_rule_standard.pdf")


# Normal distribution - left tail
μ = 2
σ = 3
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff = 5
probLessThanCutOff = cdf(Normal(μ, σ), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing, yaxis = false,
    title = L"X \sim \mathrm{N}(\mu=2,\sigma^2 = 9)")

plot!(xgrid, normaldens, color = colors[2], label = nothing,
    xlabel = L"x")

plot!([-7,1.5], [0.1,0.05], arrow = true, lw = 2, color = :black)
annotate!(-4.8, 0.107, 
    text(L"P(X\leq %$(Int(cutoff)))=%$(round(cdf(Normal(μ,σ), cutoff), digits = 3))", :black, :right, 16))

savefig(figFolder*"normal_left_tail.pdf")


# Normal distribution - left tail standardiserad
μ = 0
σ = 1
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff = (5 - 2)/3
probLessThanCutOff = cdf(Normal(μ, σ), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[2],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    title = L"Z \sim \mathrm{N}(\mu=0,\sigma^2 = 1)")

plot!(xgrid, normaldens, color = colors[6], label = nothing,
    xlabel = L"z")

plot!([-3,-0.5], [0.2,0.05], arrow = true, lw = 2, color = :black)
annotate!(-2, 0.22, 
    text(L"P(Z\leq %$(Int(cutoff)))=%$(round(cdf(Normal(μ,σ), cutoff), digits = 3))", :black, :right, 16))

savefig(figFolder*"normal_left_tail_standard.pdf")


# Normal distribution - symmetry
μ = 0
σ = 1
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff = -2
probLessThanCutOff = cdf(Normal(μ, σ), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[2],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    title = L"Z \sim \mathrm{N}(0, 1)")

plot!(xgrid, normaldens, color = colors[6], label = nothing,
    xlabel = L"z")

plot!([-3,-2.3], [0.1,0.01], arrow = true, lw = 2, color = :black)
annotate!(-1.6, 0.12, 
    text(L"P(Z\leq %$(Int(cutoff)))=%$(round(cdf(Normal(μ,σ), cutoff), digits = 3))", :black, :right, 14))

savefig(figFolder*"normal_symmetry1.pdf")

# Normal distribution - symmetry
μ = 0
σ = 1
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff = 2
probLessThanCutOff = cdf(Normal(μ, σ), cutoff)
plot(xgrid[xgrid.<=cutoff],normaldens[xgrid.<=cutoff], color=colors[2],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    title = L"Z \sim \mathrm{N}(0, 1)")

plot!(xgrid, normaldens, color = colors[6], label = nothing,
    xlabel = L"z")

plot!([-3,-1], [0.2,0.1], arrow = true, lw = 2, color = :black)
annotate!(-1.6, 0.22, 
    text(L"P(Z\leq %$(Int(cutoff)))=%$(round(cdf(Normal(μ,σ), cutoff), digits = 3))", :black, :right, 14))

savefig(figFolder*"normal_symmetry2.pdf")


μ = 0
σ = 1
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff = 2
probLessThanCutOff = 1 - cdf(Normal(μ, σ), cutoff)
plot(xgrid[xgrid.>=cutoff],normaldens[xgrid.>=cutoff], color=colors[2],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    title = L"Z \sim \mathrm{N}(0, 1)")

plot!(xgrid, normaldens, color = colors[6], label = nothing,
    xlabel = L"z")

plot!([3,2.3], [0.1,0.01], arrow = true, lw = 2, color = :black)
annotate!(4.2, 0.12, 
    text(L"P(Z\geq %$(Int(cutoff)))=%$(round(1-cdf(Normal(μ,σ), cutoff), digits = 3))", :black, :right, 14))

savefig(figFolder*"normal_symmetry3.pdf")



# Normal distribution - interval
μ = 2
σ = 3
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff1 = 0
cutoff2 = 5
probInterval = cdf(Normal(μ, σ), cutoff2) - cdf(Normal(μ, σ), cutoff1)
plot(xgrid[xgrid.>=cutoff1 .&& xgrid.<=cutoff2],
    normaldens[xgrid.>=cutoff1 .&& xgrid.<=cutoff2], color=colors[2],
    fill=(0,opacity,colors[2]), label = nothing, yaxis = false,
    title = L"X\sim\mathrm{N}(\mu=2,\sigma^2 = 9)")

plot!(xgrid, normaldens, color = colors[2], label = nothing,
    xlabel = L"x")

plot!([11,4], [0.11,0.076], arrow = true, lw = 2, color = :black)
annotate!(15, 0.117, 
    text(L"P(%$(Int(cutoff1)) \leq  X \leq %$(Int(cutoff2)))=%$(round(probInterval, digits = 3))", :black, :right, 14))

savefig(figFolder*"normal_interval_area.pdf")


# Normal distribution - interval standardized
μ = 0
σ = 1
xgrid = (μ - 4*σ):0.01:(μ + 4*σ)
normaldens = pdf.(Normal(μ, σ), xgrid)
cutoff1 = (0-2)/3
cutoff2 = (5-2)/3
probInterval = cdf(Normal(μ, σ), cutoff2) - cdf(Normal(μ, σ), cutoff1)
plot(xgrid[xgrid.>=cutoff1 .&& xgrid.<=cutoff2],
    normaldens[xgrid.>=cutoff1 .&& xgrid.<=cutoff2], color=colors[6],
    fill=(0,opacity,colors[6]), label = nothing, yaxis = false,
    title = L"Z\sim\mathrm{N}(\mu=0,\sigma^2 = 1)",
    xticks = round.([-4,-2,-2/3, 0, 1, 2, 4], digits = 2), xtickfontsize = 8)

plot!(xgrid, normaldens, color = colors[6], label = nothing,
    xlabel = L"z")

plot!([-2.3,0], [0.31,0.076], arrow = true, lw = 2, color = :black)
annotate!(-0.7, 0.33, 
    text(L"P(%$(round(cutoff1, digits = 3)) \leq  Z \leq %$(round(cutoff2, digits = 3)))=%$(round(probInterval, digits = 3))", :black, :right, 14))

savefig(figFolder*"normal_interval_area_standard.pdf")



## Ericsson and Student-t example

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



# Code for plots of Lecture 3 in Regression and Time Series Analysis course
# Plot titles and legends in Swedish

using Plots, LaTeXStrings, CSV, DataFrames, LinearAlgebra
using Statistics, Distributions
import ColorSchemes: Paired_12; colors = Paired_12
colors = Paired_12[[1,2,7,8,3,4,5,6,9,10,11,12]]
courseFolder = "/home/mv/Dropbox/Teaching/SDA1/"
figFolder = courseFolder*"slides/figs/"

Plots.reset_defaults()
gr(legend = nothing, grid = false, color = colors[2], lw = 2, legendfontsize=10,
    xtickfontsize=12, ytickfontsize=12, xguidefontsize=12, yguidefontsize=12, 
    markersize = 4, markerstrokecolor = :auto)


gr(legend = :bottomright, titlefontsize = 12)

# Load data
lifespan = DataFrame(CSV.File(download("https://github.com/mattiasvillani/Regression/raw/master/Data/healthdata.csv");header=true));
lifespan_no_usa = lifespan[1:29,:]
x = lifespan.spending


# Regression as a conditional distribution
gr(legend = :topleft)
p = plot(xlab = L"\mathrm{spending}(x)", ylab = L"\mathrm{lifespan}(y)")
b = 1.7629
a = 74.1639
sigmaEps = 1.678
Plots.scatter!(lifespan_no_usa.spending, lifespan_no_usa.lifespan, label = nothing, markersize = 3, c = :lightgray)
Plots.abline!(b, a, color = colors[4], label = L"E(Y \vert x)=\beta_0 + \beta_1 x", lw = 2)

xPoints = [1,3,5]
for x in xPoints
    μ = a + b*x
    distr = Normal(μ, sigmaEps)
    quant1 = quantile(distr, 0.01)
    quant2 = quantile(distr, 0.99)
    yGrid = quant1:0.1:quant2
    maxpdf = maximum(pdf.(distr, yGrid))
    tmp = x .+ 0.8*pdf.(distr, yGrid)/maxpdf
    plot!(tmp, yGrid, label = nothing)
    plot!([x,maximum(tmp)],[μ,μ], color = colors[1], linestyle = :dash, 
        label = nothing, lw = 1)
    annotate!([(x+0.02, μ+600, (L"\mu_{y\vert x=%$(round(x,digits = 2))}", 12, :right, :black))])
    #plot!([x-0.05, x], [μ + 0.2, μ], arrow=false, lw = 1, c = :gray, label = nothing)
    plot!([x+0.05,x+0.05],[μ-1.5*sigmaEps,μ-0.1*sigmaEps], arrow = arrow(:both), lw = 1, 
        c = :gray, label = nothing)
    annotate!([(x+0.03, μ-0.75*sigmaEps, (L"\sigma_{\varepsilon}", 12, :right, :black))])
end
p
savefig(figFolder*"regdensities.pdf")
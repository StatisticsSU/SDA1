using Plots, Distributions, LinearAlgebra, PlotUtils, StatsBase

figFolder = "/home/mv/Dropbox/Teaching/SDA1/slides/figs/"

# Plotting converging relative freq for 6 on dice
n = 10000
dice = sample([1,2,3,4,5,6], n)
dice6 = dice .== 6
relfreq = cumsum(dice6) ./ (1:n)

plot(1:n, (1/6)*ones(n,1), xlab = "antal tärningskast", 
    ylab = "relativ frekvens 6:or",
    xformatter = :plain, label = "1/6", 
    c = colors[4], lw = 1, grid = false)
plot!(1:n, relfreq, label = "relativ frekvens", 
    c = colors[2], lw = 2)


savefig(figFolder*"relativfrekvens.svg")
gr(legend = nothing, grid = false, color = colors[2], lw = 1,
    xtickfontsize=16, ytickfontsize=16, xguidefontsize=16, yguidefontsize=16,
    titlefontsize = 16, legendfontsize=16, markerstrokecolor = colors[1])

n = 3; θ = 0.7
bar(0:n,pdf(Binomial(n,θ)), linewidth = 0, xticks = (0:n),
    xlabel = L"x", ylabel  = L"\mathrm{Pr}(X=x)", bar_width = 0.4,
    xlim = [-0.5,n+0.5], title = L"X\sim\mathrm{Bin}(n=3,p=0.7)")
savefig(figFolder*"BinomialDistSDA1d.pdf")


n = 10; θ = 0.7
bar(0:n,pdf(Binomial(n,θ)), linewidth = 0, xticks = (0:n),
    xlabel = L"x", ylabel  = L"\mathrm{Pr}(X=x)", bar_width = 0.4,
    xlim = [-0.5,n+0.5], title = L"X\sim\mathrm{Bin}(n=10,p=0.7)")
savefig(figFolder*"BinomialDistSDA1a.pdf")

n = 10; θ = 0.5
bar(0:n,pdf(Binomial(n,θ)), linewidth = 0, xticks = (0:n),
    xlabel = L"x", ylabel  = L"\mathrm{Pr}(X=x)", bar_width = 0.4,
    xlim = [-0.5,n+0.5], title = L"X\sim\mathrm{Bin}(n=10,p=0.5)")
savefig(figFolder*"BinomialDistSDA1b.pdf")

gr(legend = nothing, grid = false, color = colors[2], lw = 1,
    xtickfontsize=10, ytickfontsize=10, xguidefontsize=16, yguidefontsize=16,
    titlefontsize = 16, legendfontsize=16)
n = 20; θ = 0.7
bar(0:n,pdf(Binomial(n,θ)), linewidth = 0, xticks = (0:n),
    xlabel = L"x", ylabel  = L"\mathrm{Pr}(X=x)", bar_width = 0.4,
    xlim = [-0.5,n+0.5], title = L"X\sim\mathrm{Bin}(n=20,p=0.7)")
savefig(figFolder*"BinomialDistSDA1c.pdf")


# Logistic Regression

gr(legend = nothing, grid = false, color = colors[2], lw = 1,
    xtickfontsize=14, ytickfontsize=14, xguidefontsize=16, yguidefontsize=16,
    titlefontsize = 16, legendfontsize=16, markerstrokecolor = colors[1])

β = 1.5
x = 0:0.01:8
θ = exp.(-4 .+ x*β)./(1 .+ exp.(-4 .+ x*β))
plot(x, θ, ylab = L"\mathrm{P(spam)}", lw = 3, ticks = 0:2:8, 
    yticks = 0:0.25:1,
    xlab = "antal \$-tecken i mejl", label =  nothing)
savefig(figFolder*"LogisticRegSpam.pdf")
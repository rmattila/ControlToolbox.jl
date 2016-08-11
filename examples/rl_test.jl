using ControlCore
using ControlToolbox

using PyPlot

"""
    `plot_rlocus(sys, [K])`
    Plots the root locus of `sys`.
    
    If `K` is omitted, the pole trajectories are plotted as evenly spaced
    samples.
"""
function plot_rlocus(sys::ControlCore.LtiSystem)
    rlist = rlocus(sys)

    fig = figure("rlocus_plot", figsize=(10,10))
    ax = axes()

    for (plist, k) in rlist
        for p in plist
            # 100.0 is the maximal gain. Should be calculated
            scatter(real(p),imag(p),k/100.0,marker='o')
        end
    end

    title("Root Locus")
    xlabel("Re")
    ylabel("Im")
    grid("on")
end

function plot_rlocus{T<:Real}(sys::ControlCore.LtiSystem, K::AbstractVector{T})
    # todo
end

G = tf([3, 2], [4, 2, 1])

rlocus(G)
rlocus(G, 3)
rlocus(G, [1, 2, 5])

plot_rlocus(G)


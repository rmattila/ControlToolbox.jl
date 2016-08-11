"""
    `rlocus(sys, [K])`
    Computes the root locus of `sys`.
    
    Returns the closed-loop system
        - poles at `K`, if `K` is a number
        - pole trajectories, if `K` is vector of gains
        - pole trajectories at evenly spaced intervals of the gain, if `K` is
          omitted
"""
function rlocus(sys::ControlCore.LtiSystem)                                                                                       
    # This should be adaptive (for a smooth plot)
    K = collect(linspace(1,1e2))

    return rlocus(sys, K)
end

function rlocus{T<:Real}(sys::ControlCore.LtiSystem, K::AbstractVector{T})
    rlist = Tuple{AbstractVector{Complex}, Real}[]
    for k in K
        push!(rlist, rlocus(sys, k))
    end

    return rlist
end

function rlocus(sys::ControlCore.LtiSystem, K::Real)
    plist = poles(feedback(sys,K))

    return (plist, K)
end


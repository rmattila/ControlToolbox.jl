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
  K = collect(logspace(-2,2,100))

  return rlocus(sys, K)
end

function rlocus{T<:Real}(sys::ControlCore.LtiSystem, K::AbstractVector{T})
  plist = Matrix{eltype(poles(sys))}(length(K), length(denvec(sys))-1)
  for idx in eachindex(K)
    plist[idx,:] = rlocus(sys, K[idx])[1]
  end
  (plist, K)
end

rlocus(sys::ControlCore.LtiSystem, k::Real) =  poles(feedback(sys,k)), k

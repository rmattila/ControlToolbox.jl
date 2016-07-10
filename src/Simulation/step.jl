"""
    `step(s[,t])`

Calculate the step response of system `s`.

If the final time `t` or time vector `t` is not provided, one is calculated based on the system pole
locations.
"""
function step{T1<:AbstractVector}(s::DSs, t::T1)
  u = ones(length(t), s.nu)
  y, x = lsim(s, u, t)
  return y, t, x
end

function step{T1<:AbstractVector}(s::ControlCore.DSisoTf, t::T1)
  u = ones(length(t), 1)
  y = lsim(s, u, t)
  return y, t
end

function step{T1<:AbstractVector}(s::ControlCore.DMimo, t::T1)
  u = ones(length(t), s.nu)
  y = lsim(s, u, t)
  return y, t
end

# Continuous Versions
function step{T1<:AbstractVector}(s::CSs, t::T1)
  u = ones(length(t), s.nu)
  y, x = lsim(s, u, t, zeros(s.nx, 1), :zoh)
  return y, t, x
end

function impulse{T1<:AbstractVector}(s::ControlCore.CSisoTf, t::T1)
  step(ss(s), t)[1:2]
end

function impulse{T1<:AbstractVector}(s::ControlCore.CMimo, t::T1)
  step(ss(s), t)[1:2]
end

step(s::ControlCore.LtiSystem, Tf::Real) = step(s, default_time_vector(s, Tf))
step(s::ControlCore.LtiSystem) = step(s, default_time_vector(s))

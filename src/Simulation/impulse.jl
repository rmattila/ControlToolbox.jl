"""

    `impulse(s)`

Calculate the impulse response of system `sys`.


If the final time `Tf` or time vector `t` is not provided, one is calculated based on the system pole
locations.

`y` has size `(length(t), ny, nu)`, `x` has size `(length(t), nx, nu)`
"""
# Discrete State Space
function impulse{T1<:AbstractVector}(s::DSs, t::T1)
  u = zeros(length(t), s.nu)
  x0s = zeros(s.nx, s.nu)
  u[1,:] = ones(1,s.nu)./s.Ts
  lsim(s, u, t, x0s)
end

# Discrete SISO Transfer Function
function impulse{T1<:AbstractVector}(s::ControlCore.DSisoTf, t::T1)
  u = zeros(length(t), 1)
  u[1] = 1/s.Ts
  y = lsim(s, u, t)
  return y, t
end

#  Discrete MIMO Transfer Function
function impulse{T1<:AbstractVector}(s::ControlCore.DMimo, t::T1)
  u = zeros(length(t), s.nu)
  u[1,:] = ones(1,s.nu)./s.Ts
  y = lsim(s, u, t)
  return y, t
end

# Continuous Versions
function impulse{T1<:AbstractVector}(s::CSs, t::T1)
  # impulse response equivalent to unforced response of
  # ss(A, 0, C, 0) with x0 = B.
  u = zeros(length(t), s.nu)
  imp_s = ss(s.A, zeros(s.nx, 1), s.C, zeros(s.ny, 1))
  lsim(imp_s, u, t, s.B, :zoh)
end

function impulse{T1<:AbstractVector}(s::ControlCore.CSisoTf, t::T1)
  impulse(ss(s), t)
end

function impulse{T1<:AbstractVector}(s::ControlCore.CMimo, t::T1)
  impulse(ss(s), t)
end

impulse(s::ControlCore.LtiSystem, Tf::Real) = impulse(s, default_time_vector(s, Tf))
impulse(s::ControlCore.LtiSystem) = impulse(s, default_time_vector(s))

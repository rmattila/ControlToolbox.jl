module ControlToolbox

using Reexport
@reexport using ControlCore

import Base: step

export c2d, lsim, step, impulse

using DSP

include("c2d.jl")
include("Simulation/utils.jl")
include("Simulation/lsim.jl")
include("Simulation/step.jl")
include("Simulation/impulse.jl")


end # module

module ControlToolbox

using Reexport
@reexport using ControlCore

import Base: step

export c2d, lsim, step, impulse, isstable

using DSP

include("c2d.jl")
include("simulation/utils.jl")
include("simulation/lsim.jl")
include("simulation/step.jl")
include("simulation/impulse.jl")
include("analysis/isstable.jl")

end # module

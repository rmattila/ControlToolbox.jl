isstable{T<:ControlCore.DSiso}(s::T) = maximum(abs([pole(sys), 0])) >= 1

isstable{T<:ControlCore.CSiso}(s::T) = maximum(real([pole(sys), 0])) >= 0

isstable{T<:ControlCore.MimoSystem}(s::T) = map(isstable, getmatrix(s))
# TODO: How to handle pole-zero cancellation

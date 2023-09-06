"""
    scale_axis(axis, factor)

Scale the number of points on an axis by the given factor or to a specific number.
"""
function scale_axis(axis; factor=nothing, N=nothing)
    if isnothing(factor) & isnothing(N)
        error("N or factor required.")
    end

    len = if isnothing(N)
        Int(ceil(length(axis).*factor))
    else
        N
    end

	axis_new = range(first(axis), last(axis), length=len)
	Base.convert.(eltype(axis), axis_new)
end
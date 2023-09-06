module Ginterpolations


"""
Abstract Grid of a MUST.Box object.
"""
abstract type AbstractBoxGrid
end

"""
Abstract Axis of a MUST.Box object.
"""
abstract type AbstractBoxAxis
end


export gevaluate!, ginterpolate, Grid


include("_grids.jl")
include("_grid_interpolation.jl")
include("_grid_construction.jl")

end

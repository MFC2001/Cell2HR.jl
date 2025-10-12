
"""
	read(path::AbstractString, ::Type{T}; kwargs...) where{T <: FileFormat}
	read(io::IO, ::Type{T}; kwargs...) where{T <: FileFormat}

Read data from a file or an IO stream in the specified file format.
"""
function Base.read(path::AbstractString, ::Type{T}; kwargs...) where{T <: FileFormat}
	return open(path, "r") do io
		read(io, T; kwargs...)
	end
end


include("./HR.jl")
include("./ORBITAL.jl")
include("./POSCAR.jl")



"""
	write(path::AbstractString, data, ::Type{T}; mode = "w", comment = "", kwargs...) where {T <: FileFormat}
	write(io::IO, data, ::Type{T}; comment = "", kwargs...) where {T <: FileFormat}
	
Write data to a file or an IO stream in the specified file format.
"""
function Base.write(path::AbstractString, data, ::Type{T}; mode = "w", kwargs...) where {T <: FileFormat}
	mkpath(dirname(path))
	return open(path, mode) do io
		write(io, data, T; kwargs...)
	end
end


include("./HR.jl")
include("./ORBITAL.jl")
include("./POSCAR.jl")


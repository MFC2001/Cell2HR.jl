export FileFormat
export POSCAR
export wannier90_hr, wannier90_centres

abstract type FileFormat end
struct POSCAR <: FileFormat end
struct wannier90_hr <: FileFormat end
struct wannier90_centres <: FileFormat end


include("./read/read.jl")
include("./write/write.jl")

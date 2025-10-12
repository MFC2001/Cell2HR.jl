
const Mat3{T} = SMatrix{3, 3, T, 9}
const Vec3{T} = SVector{3, T}

include("./CrystallographyCore/CrystallographyCore.jl")

include("./HR.jl")
include("./ORBITAL.jl")

include("./AtomHR.jl")
include("./SuperCell.jl")

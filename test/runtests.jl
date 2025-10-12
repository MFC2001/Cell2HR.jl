using Cell2HR
using Test

@testset "Cell2HR.jl" begin
    # Write your tests here.
    include("graphene_cluster.jl")
    include("LiF_cubic2primitive.jl")
    include("./multiple_hr.jl")
end

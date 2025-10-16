
unitcellfolder = joinpath(@__DIR__, "../data/LiF/unitcell/")
supercellfolder = joinpath(@__DIR__, "../data/LiF/supercell/")

include(joinpath(@__DIR__, "../src/Cell2HR.jl"))
import .Cell2HR as CH
CH.ContractHR(
	joinpath(supercellfolder, "wannier90_hr.dat"),
	joinpath(supercellfolder, "wannier90_centres.xyz"),
	joinpath(supercellfolder, "POSCAR"),
	joinpath(unitcellfolder, "POSCAR");
	heps = 0,
	ucperiodicity = [1, 1, 1],
	scperiodicity = [1, 1, 1],
)

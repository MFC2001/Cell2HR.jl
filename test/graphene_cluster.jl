
unitcellfolder = joinpath(@__DIR__, "../data/graphene/unitcell/")
supercellfolder = joinpath(@__DIR__, "../data/graphene/supercell/")

ExpandHR(
	joinpath(unitcellfolder, "wannier90_hr.dat"),
	joinpath(unitcellfolder, "wannier90_centres.xyz"),
	joinpath(unitcellfolder, "graphene.vasp"),
	joinpath(supercellfolder, "C6.vasp");
	heps = 0,
	ucperiodicity = [1, 1, 0],
	scperiodicity = [0, 0, 0],
)
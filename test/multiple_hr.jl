
unitcellfolder = "../data/graphene/unitcell/"
supercellfolder = "../data/graphene/supercell/"

ExpandHR(
	fill(joinpath(unitcellfolder, "wannier90_hr.dat"), 3),
	joinpath(unitcellfolder, "wannier90_centres.xyz"),
	joinpath(unitcellfolder, "graphene.vasp"),
	joinpath(supercellfolder, "C6.vasp");
	heps = 0,
	ucperiodicity = [1, 1, 0],
	scperiodicity = [0, 0, 0],
)


unitcellfolder = "../data/LiF/unitcell/"
supercellfolder = "../data/LiF/supercell/"

ContractHR(
	fill(joinpath(supercellfolder, "wannier90_hr.dat"), 3),
	joinpath(supercellfolder, "wannier90_centres.xyz"),
	joinpath(supercellfolder, "POSCAR"),
	joinpath(unitcellfolder, "POSCAR");
	heps = 0,
	ucperiodicity = [1, 1, 1],
	scperiodicity = [1, 1, 1],
)


unitcellfolder = "../data/LiF/unitcell/"
supercellfolder = "../data/LiF/supercell/"

ContractHR(
	joinpath(supercellfolder, "wannier90_hr.dat"),
	joinpath(supercellfolder, "wannier90_centres.xyz"),
	joinpath(supercellfolder, "POSCAR"),
	joinpath(unitcellfolder, "POSCAR");
	heps = 0,
	ucperiodicity = [1, 1, 1],
	scperiodicity = [1, 1, 1],
)

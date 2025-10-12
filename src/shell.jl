"""
	ExpandHR(uchrfile::AbstractString, ucorbitalfile::AbstractString, ucposcarfile::AbstractString, scposcarfile::AbstractString;
		heps::Real = 0,	ucperiodicity = Bool[1, 1, 1],	scperiodicity = Bool[1, 1, 1], 
		finduc = "auto", supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing)
"""
function ExpandHR(
	uchrfile::AbstractString,
	ucorbitalfile::AbstractString,
	ucposcarfile::AbstractString,
	scposcarfile::AbstractString;
	heps::Real = 0,
	ucperiodicity = Bool[1, 1, 1],
	scperiodicity = Bool[1, 1, 1],
	finduc::AbstractString = "auto",
	supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing,
)

	uchr = read(uchrfile, wannier90_hr; heps, readimag = 'Y')
	ucorbital = read(ucorbitalfile, wannier90_centres)
	uccell = read(ucposcarfile, POSCAR; period = ucperiodicity)

	sccell = read(scposcarfile, POSCAR; period = scperiodicity)

	(schr, scorbital) = ExpandHR(uchr, ucorbital, uccell, sccell; finduc, supercell_path)

	scfolder = dirname(scposcarfile)
	write(joinpath(scfolder, "hr.dat"), schr, wannier90_hr; mode = "w",
		comment = "From ExpandHR.")
	write(joinpath(scfolder, "orbital.xyz"), scorbital, wannier90_centres; mode = "w",
		comment = "From ExpandHR.")

	return nothing
end
"""
	ExpandHR(uchrfile::AbstractVector{<:AbstractString}, ucorbitalfile::AbstractString, ucposcarfile::AbstractString, scposcarfile::AbstractString;
		heps::Real = 0,	ucperiodicity = Bool[1, 1, 1],	scperiodicity = Bool[1, 1, 1], 
		finduc = "auto", supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing)
"""
function ExpandHR(
	uchrfiles::AbstractVector{<:AbstractString},
	ucorbitalfile::AbstractString,
	ucposcarfile::AbstractString,
	scposcarfile::AbstractString;
	heps::Real = 0,
	ucperiodicity = Bool[1, 1, 1],
	scperiodicity = Bool[1, 1, 1],
	finduc::AbstractString = "auto",
	supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing,
)

	uchrs = map(uchrfile -> read(uchrfile, wannier90_hr; heps, readimag = 'Y'), uchrfiles)
	ucorbital = read(ucorbitalfile, wannier90_centres)
	uccell = read(ucposcarfile, POSCAR; period = ucperiodicity)

	sccell = read(scposcarfile, POSCAR; period = scperiodicity)

	(schrs, scorbital) = ExpandHR(uchrs, ucorbital, uccell, sccell; finduc, supercell_path)

	scfolder = dirname(scposcarfile)
	map(i -> write(joinpath(scfolder, "hr_$i.dat"), schrs[i], wannier90_hr; mode = "w",
			comment = "From ExpandHR."), eachindex(schrs))
	write(joinpath(scfolder, "orbital.xyz"), scorbital, wannier90_centres; mode = "w",
		comment = "From ExpandHR.")

	return nothing
end
"""
	ContractHR(schrfile::AbstractString, scorbitalfile::AbstractString, scposcarfile::AbstractString, ucposcarfile::AbstractString;
		heps::Real = 0,	ucperiodicity = Bool[1, 1, 1],	scperiodicity = Bool[1, 1, 1], 
		finduc = "auto", supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing)
"""
function ContractHR(
	schrfile::AbstractString,
	scorbitalfile::AbstractString,
	scposcarfile::AbstractString,
	ucposcarfile::AbstractString;
	heps::Real = 0,
	ucperiodicity = Bool[1, 1, 1],
	scperiodicity = Bool[1, 1, 1],
	finduc::AbstractString = "auto",
	supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing,
)

	schr = read(schrfile, wannier90_hr; heps, readimag = 'Y')
	scorbital = read(scorbitalfile, wannier90_centres)
	sccell = read(scposcarfile, POSCAR; period = scperiodicity)

	uccell = read(ucposcarfile, POSCAR; period = ucperiodicity)

	(uchr, ucorbital) = ContractHR(schr, scorbital, sccell, uccell; finduc, supercell_path)

	ucfolder = dirname(ucposcarfile)
	write(joinpath(ucfolder, "hr.dat"), uchr, wannier90_hr; mode = "w",
		comment = "From ContractHR.")
	write(joinpath(ucfolder, "orbital.xyz"), ucorbital, wannier90_centres; mode = "w",
		comment = "From ContractHR.")

	return nothing
end
"""
	ContractHR(schrfile::AbstractVector{<:AbstractString}, scorbitalfile::AbstractString, scposcarfile::AbstractString, ucposcarfile::AbstractString;
		heps::Real = 0,	ucperiodicity = Bool[1, 1, 1],	scperiodicity = Bool[1, 1, 1], 
		finduc = "auto", supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing)
"""
function ContractHR(
	schrfiles::AbstractVector{<:AbstractString},
	scorbitalfile::AbstractString,
	scposcarfile::AbstractString,
	ucposcarfile::AbstractString;
	heps::Real = 0,
	ucperiodicity = Bool[1, 1, 1],
	scperiodicity = Bool[1, 1, 1],
	finduc::AbstractString = "auto",
	supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing,
)

	schrs = map(schrfile -> read(schrfile, wannier90_hr; heps, readimag = 'Y'), schrfiles)
	scorbital = read(scorbitalfile, wannier90_centres)
	sccell = read(scposcarfile, POSCAR; period = scperiodicity)

	uccell = read(ucposcarfile, POSCAR; period = ucperiodicity)

	(uchrs, ucorbital) = ContractHR(schrs, scorbital, sccell, uccell; finduc, supercell_path)

	ucfolder = dirname(ucposcarfile)
	map(i -> write(joinpath(ucfolder, "hr_$i.dat"), uchrs[i], wannier90_hr; mode = "w",
		comment = "From ContractHR."), eachindex(uchrs))
	write(joinpath(ucfolder, "orbital.xyz"), ucorbital, wannier90_centres; mode = "w",
		comment = "From ContractHR.")

	return nothing
end
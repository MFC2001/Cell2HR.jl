
function ExpandHR(
	unithrs::AbstractVector{<:HR},
	unitorbital::ORBITAL,
	unitcell::Cell,
	cell::Cell; #larger than unitcell.
	finduc::AbstractString = "auto",
	supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing,
	ucazimuth::Tuple{<:Real, <:Real} = (0, 0),
	outhr::AbstractString = "value",
	outorb::AbstractString = "value",
	outucorientation::AbstractString = "N",
)

	#Check the input parameters.
	outparameter = [outhr, outorb, outucorientation]
	checkKeywords(finduc, outparameter)
	(unitcell, cell) = checkCell(unitcell, cell)


	EpsPara = Dict(
		#Used by findunitcell!, permissible error between atom locations in operated unitcell and cell's supercell.
		"atomeps" => 0.1,
		#Used by findunitcell!, sum square of permissible error between atom locations in operated unitcell and cell's supercell.
		"sumeps" => 0.2,
		#Used by classifyCell, permissible error between atom locations in unitcell's supercell and cell.
		"sc_uc atom" => 0.2,
		#Used by atompath_sum in expandhr, permissible error when search cell's atom transition path in unithr.path.
		"sc_uc path" => 0.2,
		#Used by maxhrpath in hrsplit, the added value of the farthest transition lattice distance in unithr.path.
		"unithr path" => 0.1,
	)

	original_unitcell = deepcopy(unitcell)

	#This function will use name to judge whether atom is the same, so need cell.name is corresponding to unitcell.name, recommend using atom name.
	if finduc == "custom"
	else
		(unitcell, ucazimuth) = findunitcell(cell, unitcell; aimazimuth = ucazimuth, mode = finduc, supercell_path, atomeps = EpsPara["atomeps"], sumeps = EpsPara["sumeps"])
	end

	#Preprocessing unitcell HR.
	namelist!(unitcell)
	#The supercell may not be the simple repetition of unitcell, so split hr to atom pair's hrs.
	unit_atomhrs = map(unithr -> hrsplit(unithr, unitcell, unitorbital.belonging, EpsPara["unithr path"]), unithrs)


	#Create cell's hr from unitcell's hr.
	sum_results = map(unit_atomhr -> expandhr(cell, unitcell, unit_atomhr, EpsPara), unit_atomhrs)
	# (hr_path, orbital_index, atom_index) = expandhr(cell, unitcell, unit_atomhr, EpsPara)


	#Generate output data.
	orbital_index = sum_results[1][2]
	hrs = map(i -> postprocessHR(outhr, sum_results[i][1], unithrs[i], collect(1:size(orbital_index, 1))), eachindex(unithrs))
	#orbital_index:[atom_index atom_orb_index unit_atom_index unit_orb_index]
	orbital = postprocessORBITAL(outorb, orbital_index, unitorbital, original_unitcell.lattice, unitcell.lattice, cell)


	if outucorientation[1] ∈ ['N', 'n']
		return hrs, orbital
	elseif outucorientation[1] ∈ ['Y', 'y']
		return hrs, orbital, ucorientation
	end
end

function ContractHR(
	superhrs::AbstractVector{<:HR},
	superorbital::ORBITAL,
	supercell::Cell,
	cell::Cell; #equal to or less than supercell.
	finduc::AbstractString = "auto",
	supercell_path::Union{Nothing, AbstractVector{<:AbstractVector{<:Integer}}} = nothing,
	ucazimuth::Tuple{<:Real, <:Real} = (0, 0),
	outhr::AbstractString = "value",
	outorb::AbstractString = "value",
	outucorientation::AbstractString = "N",
)

	#Check the input parameters.
	outparameter = [outhr, outorb, outucorientation]
	checkKeywords(finduc, outparameter)
	(supercell, cell) = checkCell(supercell, cell)


	EpsPara = Dict(
		#Used by findunitcell!, permissible error between atom locations in operated unitcell and cell's supercell.
		"atomeps" => 0.1,
		#Used by findunitcell!, sum square of permissible error between atom locations in operated unitcell and cell's supercell.
		"sumeps" => 0.2,
		#Used by classifyCell, permissible error between atom locations in unitcell's supercell and cell.
		"sc_uc atom" => 0.2,
		#Used by atompath_sum in poscar2hr, permissible error when search cell's atom transition path in unithr.path.
		"sc_uc path" => 0.2,
		#Used by maxhrpath in hrsplit, the added value of the farthest transition lattice distance in unithr.path.
		"unithr path" => 0.1,
	)

	# Need cell without change to generate orbital.
	original_cell = deepcopy(cell)

	#This function will use name to judge whether atom is the same, so need cell.name is corresponding to unitcell.name, recommend using atom name.
	if finduc == "custom"
	else
		(cell, ucazimuth) = findunitcell(supercell, cell; aimazimuth = ucazimuth, mode = finduc, supercell_path, atomeps = EpsPara["atomeps"], sumeps = EpsPara["sumeps"])
	end

	#Preprocessing unitcell HR.
	namelist!(supercell)
	#The supercell may not be the simple repetition of unitcell, so split hr to atom pair's hrs.
	super_atomhrs = map(superhr -> hrsplit(superhr, supercell, superorbital.belonging, EpsPara["unithr path"]), superhrs)


	#Create cell's hr from unitcell's hr.
	sum_results = map(super_atomhr -> contracthr(cell, supercell, super_atomhr, EpsPara), super_atomhrs)
	# (hr_path, orbital_index, atom_index) = contracthr(cell, supercell, super_atomhr, EpsPara)


	#Generate output data.
	orbital_index = sum_results[1][2]
	hrs = map(i -> postprocessHR(outhr, sum_results[i][1], superhrs[i], collect(1:size(orbital_index, 1))), eachindex(superhrs))
	#orbital_index:[atom_index atom_orb_index super_atom_index super_orb_index]
	orbital = postprocessORBITAL(outorb, orbital_index, superorbital, cell.lattice, original_cell.lattice, original_cell)


	if outucorientation[1] ∈ ['N', 'n']
		return hrs, orbital
	elseif outucorientation[1] ∈ ['Y', 'y']
		return hrs, orbital, ucorientation
	end
end

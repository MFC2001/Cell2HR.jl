# Cell2HR.jl

[![Build Status](https://github.com/MFC2001/Cell2HR.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/MFC2001/Cell2HR.jl/actions/workflows/CI.yml?query=branch%3Amaster)

A Julia package for tight-binding models in condensed-matter physics. Cell2HR is mainly used to obtain hopping terms of a supercell from a unitcell and supports different periodic boundary condition. For example, you can obtain the hopping terms of a ribbon structure from the corresponding unitcell's hopping terms.

## Installation

The package can be installed with the Julia package manager.
From [the Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/), type `]` to enter
the [Pkg mode](https://docs.julialang.org/en/v1/stdlib/REPL/#Pkg-mode) and run:

```julia
pkg> add Cell2HR
```

Or, equivalently, via [`Pkg.jl`](https://pkgdocs.julialang.org/v1/):

```julia
julia> import Pkg; Pkg.add("Cell2HR")
```

## Quick start

This package provide two functions `ExpandHR` and `ContractHR`, type `?` to enter
the [Help mode](https://docs.julialang.org/en/v1/stdlib/REPL/#Help-mode) and run:

```julia
help?> ExpandHR
help?> ContractHR
```

for the full docstrings.

## Multi-threads

This package support Julia's native multi-threading acceleration. All you need to do is setting the number of threads.

## Zero-knowledge workflow

If you already have

| File            | Content                                               |
| --------------- | ----------------------------------------------------- |
| `uchrfile`      | unitcell hopping terms (`wannier90_hr.dat`)           |
| `ucorbitalfile` | unitcell orbital positions (`wannier90_centres.xyz`)  |
| `ucposcarfile`  | unitcell structure (`POSCAR.vasp`)                    |
| `scposcarfile`  | target supercell structure (`POSCAR.vasp`)            |

and the periodicity of unitcell and supercell, simply call

```julia
julia> ExpandHR(uchrfile, ucorbitalfile, ucposcarfile, scposcarfile; ucperiodicity, scperiodicity)
```

Here all the file is a path string, and periodicity is a vector with three arbitrary 1(0). No need to align position or orientation, just make sure the supercell contains at least one copy of the unitcell.

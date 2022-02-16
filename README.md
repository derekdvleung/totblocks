# Introduction

TotBlocks are a series of 3D-printed mineral building blocks for constructing the crystal structures of biopyribole-palysepiole minerals.

[![DOI](https://zenodo.org/badge/398404495.svg)](https://zenodo.org/badge/latestdoi/398404495)

## How do I 3D print TotBlocks?

We are currently working on a tutorial video for 3D printing TotBlocks.
The 3D models are available as \*.3mf (Prusaslicer project files) and \*.stl files for 3D printing. 
Note that the \3mf files include the positions for support enforcers for *O* modules (`oblock`), 
whereas for \*.stl files the support enforcer (`stl/oblock/oblock-support-enforcer`) has to be added for the overhanging horizontal pegs of the *O* modules.

## Questions?



# Repository contents

<!-- todo: add links -->

- `3mf`						All the \*.3mf (Prusaslicer project files) can be found in this folder.
<!-- todo: add these files -->

- `stl/`					All the \*.stl files can be found in this folder.
  -	`connectors/`			Hexagonal pegs used to vertically connect *T*-*O*-*T* sheets for layered minerals.
	- [`brucite-connector.stl`](stl/connectors/brucite-connector.stl)		For brucite structure
	- `chlorite-connector.stl`		For chlorite structure
	- `lizardite-connector.stl`		For lizardite (kaolinite-serpentine group) structure
	- `mica-connector.stl`			For mica (2:1 phyllosilicate) structure
	
- `dual/` 					3D models used for the dual-colour version of TotBlocks (single chain, *w* = 1). 
							Each model has two parts, corresponding to two the different colours used in dual extrusion printing.
							These models should be overlain in the slicer for dual printing.
  - `oblock-m2-plus-dual-0.stl`		*O<sup>+</sup>* module, part 1.
  - `oblock-m2-plus-dual-1.stl`		*O<sup>+</sup>* module, part 2.
  - `tblock-n1-minus-dual-0.stl`	*T<sup>−</sup>* module, part 1.[^1]
  - `tblock-n1-minus-dual-1.stl`	*T<sup>−</sup>* module, part 2.[^1]
  - `tblock-n1-plus-dual-0.stl`		*T<sup>+</sup>* module, part 1.[^1]
  - `tblock-n1-plus-dual-1.stl`		*T<sup>+</sup>* module, part 2.[^1]
		
- `oblock/`					*O* modules (`m` = *Z* from Nespolo and Bouznari, 2017)
  - `oblock-m2-minus.stl`			Single chain (*w* = 1) *O<sup>−</sup>* module.
  - `oblock-m2-plus.stl`			Single chain (*w* = 1) *O<sup>+</sup>* module.
  - `oblock-m3-plus.stl`			*Z*<sub>3</sub> *O<sup>+</sup>* module for kalifersite.
  - `oblock-m5-minus.stl`			Double chain (*w* = 2) *O<sup>−</sup>* module.
  - `oblock-m5-plus.stl`			Double chain (*w* = 2) *O<sup>+</sup>* module.
  - `oblock-m6-plus.stl`			*Z*<sub>6</sub> *O<sup>+</sup>* module for kalifersite.
  - `oblock-m8-minus.stl`			Triple chain (*w* = 3) *O<sup>−</sup>* module.
  - `oblock-m8-plus.stl`			Triple chain (*w* = 3) *O<sup>+</sup>* module.
  - `oblock-support-enforcer.stl`	Support enforcer for the *O* modules. When slicing (in Prusaslicer), right click on the *O* module, then "add support enforcer". 
									It should be in the correct spot for single chain modules, but will need to be repositioned for other modules.
									The support enforcer should be placed so that it covers the top widthwise pegs (these are overhangs, and thus need support).
  - `single-octahedron-clips.stl`	An octahedron that fits between *O* modules that are joined by phyllosilicate-type linkages to fill in the missing sites.
  - `single-octahedron.stl`			An octahedron that fits between *O* modules that are joined by phyllosilicate-type linkages to fill in the missing sites.
									This piece has additional clips that make it easier to hold on when the single octahedron is at the front or back of an *O* module.
	
- `quartz`					Experimental modules for quartz. These modules do not have pags and thus have to be glued together to extend the structure.
  - `quartz-module.stl`				3<sub>2</sub> screw axis module for quartz (two repeats).

- `tblock`					T modules (`n` = *w* from Leung and dePolo, 202x)
  - `tblock-n1-minus.stl`			Single chain (*w* = 1) *T<sup>−</sup>* module.[^1]
  - `tblock-n1-plus.stl`			Single chain (*w* = 1) *T<sup>+</sup>* module.[^1]
  - `tblock-n2-minus.stl`			Double chain (*w* = 2) *T<sup>−</sup>* module.[^1]
  - `tblock-n2-plus.stl`			Double chain (*w* = 2) *T<sup>+</sup>* module.[^1]
  - `tblock-n3-minus.stl`			Triple chain (*w* = 3) *T<sup>−</sup>* module.[^1]
  - `tblock-n3-plus.stl`			Triple chain (*w* = 3) *T<sup>+</sup>* module.[^1]
  - `tblock-n4-minus.stl`			Quadruple chain (*w* = 4) *T<sup>−</sup>* module.[^1] 
  - `tblock-n4-plus.stl`			Quadruple chain (*w* = 4) *T<sup>+</sup>* module.[^1]
  
  
- `LICENSE` 				The copyright license (GPLv3) for the TotBlocks project.
- `totblocks.scad`			The source code to generate TotBlocks. See below for method documentation for totblocks.scad.

[^1]: Note that the *T<sup>+</sup>* and *T<sup>−</sup>* notation is used here to differentiate between the two types of T modules. 
 However, the *T<sup>+</sup>* and *T<sup>−</sup>* notation actually corresponds to the orientation of the *T* modules (apices pointing up = <sup>+</sup>, down = <sup>−</sup>) rather than the modules themselves.


# Method documentation

## Hard-coded parameters
<!-- todo: flush this out -->

## Modules

	tBlock (n = 1, apex = PLUS);

Produces a *T* module of certain width and polarity.

`n` = width of module (`1` = single chain, `2` = double chain, `3` = triple chain)

`apex` = direction that the tetrahedra point (`PLUS` or `MINUS`)[^1]

***

	oBlock (m = 2, apex = PLUS);

Produces an *O* module of certain width and polarity

`m` = number of *M* sites in the module (`2` = single chain, `5` = double chain, `8` = triple chain)

`apex` = direction that the octahedra point (`PLUS` or `MINUS`)

***

	oBlockKalifersite (m = 2, apex = PLUS);

A temporary method for producing O modules for kalifersite, which have the width-wise pegs removed. It is anticipated that this method will be deprecated and added to the `oBlock` method.
 
`m` = number of *M* sites in the module (`2` = single chain, `5` = double chain, `8` = triple chain)

`apex` = direction that the octahedra point (`PLUS` or `MINUS`)


## Single octahedron pieces


	oBlockOne (apex = PLUS, pegs = true);

Produces a single octahedron piece. Note that there is no difference between PLUS and MINUS versions.

`apex` = direction that the octahedra point (`PLUS` or `MINUS`)

`pegs` = if `TRUE`, includes clips for the octahedra; if `FALSE`, does not include clips


## Peg connectors


	micaPeg ();

Produces a vertical peg for the mica-group minerals.

***

	chloriteBrucitePeg (length);

Produces a vertical peg for the chlorite and brucite groups, as well as lizardite (kaolinite-serpentine group)

`length` = length of peg (chlorite = `CHLORITE_HEIGHT`, brucite = `BRUCITE_HEIGHT`, lizardite = `LIZARDITE_HEIGHT`)


## Dual prints


	oBlockDual (apex = PLUS, dual = 0);

Produces two parts of a dual print for single-chain-width *O* modules.

`apex` = direction that the octahedra point (`PLUS` or `MINUS`)

`dual` = part number (`0` or `1`)

***

	tBlockDual2 (n = 1, apex = PLUS, dual = 0);

Produces two parts of a dual print for *T* modules.

`n` = width of module (`1` = single chain, `2` = double chain, `3` = triple chain)

`apex` = direction that the tetrahedra point (`PLUS` or `MINUS`)[^1]

`dual` = part number (`0` or `1`)

## Quartz

	quartzModule ();

Produces a quartz module.

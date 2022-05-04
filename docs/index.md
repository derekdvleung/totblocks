* TOC
{:toc}

<!-- This is a test landing page for TotBlocks. -->

# Introduction

TotBlocks are a series of 3D-printed mineral building blocks for constructing the crystal structures of biopyribole-palysepiole minerals.

[![DOI](https://zenodo.org/badge/398404495.svg)](https://zenodo.org/badge/latestdoi/398404495)

## How do I 3D print TotBlocks?

The 3D models are available as \*.3mf (PrusaSlicer project files) and \*.stl files for 3D printing. 
Note that the \*.3mf files include the positions for support enforcers for *O* modules (`oblock`), 
whereas for \*.stl files the support enforcer (`stl/oblock/oblock-support-enforcer`) has to be added for the overhanging horizontal pegs of the *O* modules. 
When slicing (in PrusaSlicer), right click on the *O* module, then "add support enforcer".
It should be in the correct spot for single chain modules, but will need to be repositioned for other modules.
The support enforcer should be placed so that it covers the top widthwise pegs (these are overhangs, and thus need supports).

## Questions?

If you have any questions, start a thread in the [discussion](https://github.com/derekdvleung/totblocks/discussions)!
If you see any issues, please submit an [issue](https://github.com/derekdvleung/totblocks/issues).


# Repository contents

<!-- todo: add links -->

- [`3mf/`](3mf/)					All the \*.3mf (PrusaSlicer project files) can be found in this folder. See below (stl folder contents) for descriptions of the respective /*.3mf files.
<!-- todo: add these files -->

- [`stl/`](stl/)					All the \*.stl files can be found in this folder.
  -	[`connectors/`](stl/connectors/)				Hexagonal pegs used to vertically connect *T*-*O*-*T* sheets for layered minerals.
	- [`brucite-connector.stl`](stl/connectors/brucite-connector.stl)			For brucite structure
	- [`chlorite-connector.stl`](stl/connectors/chlorite-connector.stl)			For chlorite structure
	- [`lizardite-connector.stl`](stl/connectors/lizardite-connector.stl)		For lizardite (kaolinite-serpentine group) structure
	- [`mica-connector.stl`](stl/connectors/mica-connector.stl)					For mica (2:1 phyllosilicate) structure
	
  - [`dual/`](stl/dual/) 							3D models used for the dual-colour version of TotBlocks (single chain, *w* = 1). 
													Each model has two parts, corresponding to two the different colours used in dual extrusion printing.
													These models should be overlain in the slicer for dual printing.
    - [`oblock-m2-plus-dual-0.stl`](stl/dual/oblock-m2-plus-dual-0.stl)			*O<sup>+</sup>* module, part 1.
    - [`oblock-m2-plus-dual-1.stl`](stl/dual/oblock-m2-plus-dual-1.stl)			*O<sup>+</sup>* module, part 2.
    - [`tblock-n1-minus-dual-0.stl`](stl/dual/oblock-n1-minus-dual-0.stl)		*T<sup>−</sup>* module, part 1.[^1]
    - [`tblock-n1-minus-dual-1.stl`](stl/dual/oblock-n1-minus-dual-1.stl)		*T<sup>−</sup>* module, part 2.[^1]
    - [`tblock-n1-plus-dual-0.stl`](stl/dual/oblock-m2-plus-dual-0.stl)			*T<sup>+</sup>* module, part 1.[^1]
    - [`tblock-n1-plus-dual-1.stl`](stl/dual/oblock-m2-plus-dual-1.stl)			*T<sup>+</sup>* module, part 2.[^1]
		
  - [`oblock/`](stl/oblock/)						*O* modules (`m` = *Z* from Nespolo and Bouznari, 2017)
    - [`oblock-m2-minus.stl`](stl/oblock/oblock-m2-minus.stl)					Single chain (*w* = 1) *O<sup>−</sup>* module.
    - [`oblock-m2-plus.stl`](stl/oblock/oblock-m2-plus.stl)						Single chain (*w* = 1) *O<sup>+</sup>* module.
    - [`oblock-m3-plus.stl`](stl/oblock/oblock-m3-plus.stl)						*Z*<sub>3</sub> *O<sup>+</sup>* module for kalifersite.
    - [`oblock-m5-minus.stl`](stl/oblock/oblock-m5-minus.stl)					Double chain (*w* = 2) *O<sup>−</sup>* module.
    - [`oblock-m5-plus.stl`](stl/oblock/oblock-m5-plus.stl)						Double chain (*w* = 2) *O<sup>+</sup>* module.
    - [`oblock-m6-plus.stl`](stl/oblock/oblock-m6-plus.stl)						*Z*<sub>6</sub> *O<sup>+</sup>* module for kalifersite.
    - [`oblock-m8-minus.stl`](stl/oblock/oblock-m8-minus.stl)					Triple chain (*w* = 3) *O<sup>−</sup>* module.
    - [`oblock-m8-plus.stl`](stl/oblock/oblock-m8-plus.stl)						Triple chain (*w* = 3) *O<sup>+</sup>* module.
    - [`oblock-m11-minus.stl`](stl/oblock/oblock-m11-minus.stl)					Quadruple chain (*w* = 4) *O<sup>−</sup>* module.
    - [`oblock-m11-plus.stl`](stl/oblock/oblock-m11-plus.stl)					Quadruple chain (*w* = 4) *O<sup>+</sup>* module.
    - [`oblock-support-enforcer.stl`](stl/oblock/oblock-support-enforcer.stl)	Support enforcer for the *O* modules. When slicing (in PrusaSlicer), right click on the *O* module, then "add support enforcer". 
																				It should be in the correct spot for single chain modules, but will need to be repositioned for other modules.
																				The support enforcer should be placed so that it covers the top widthwise pegs (these are overhangs, and thus need support).
    - [`single-octahedron-clips.stl`](stl/oblock/single-octahedron-clips.stl)	An octahedron that fits between *O* modules that are joined by phyllosilicate-type linkages to fill in the missing sites.
    - [`single-octahedron.stl`](stl/oblock/single-octahedron.stl)				An octahedron that fits between *O* modules that are joined by phyllosilicate-type linkages to fill in the missing sites.
																				This piece has additional clips that make it easier to hold on when the single octahedron is at the front or back of an *O* module.
	
  - [`quartz`](stl/quartz/)														Experimental modules for quartz. These modules do not have pags and thus have to be glued together to extend the structure.
    - [`quartz-module.stl`](stl/quartz/quartz-module.stl)						3<sub>2</sub> screw axis module for quartz (two repeats).

  - [`tblock`](stl/tblock/)							T modules (`n` = *w* from Leung and dePolo, 202x)
    - [`tblock-n1-minus.stl`](stl/tblock/tblock-n1-minus.stl)					Single chain (*w* = 1) *T<sup>−</sup>* module.[^1]
    - [`tblock-n1-plus.stl`](stl/tblock/tblock-n1-plus.stl)						Single chain (*w* = 1) *T<sup>+</sup>* module.[^1]
    - [`tblock-n2-minus.stl`](stl/tblock/tblock-n2-minus.stl)					Double chain (*w* = 2) *T<sup>−</sup>* module.[^1]
    - [`tblock-n2-plus.stl`](stl/tblock/tblock-n2-plus.stl)						Double chain (*w* = 2) *T<sup>+</sup>* module.[^1]
    - [`tblock-n3-minus.stl`](stl/tblock/tblock-n3-minus.stl)					Triple chain (*w* = 3) *T<sup>−</sup>* module.[^1]
    - [`tblock-n3-plus.stl`](stl/tblock/tblock-n3-plus.stl)						Triple chain (*w* = 3) *T<sup>+</sup>* module.[^1]
    - [`tblock-n4-minus.stl`](stl/tblock/tblock-n4-minus.stl)					Quadruple chain (*w* = 4) *T<sup>−</sup>* module.[^1] 
    - [`tblock-n4-plus.stl`](stl/tblock/tblock-n4-plus.stl)						Quadruple chain (*w* = 4) *T<sup>+</sup>* module.[^1]
  
  
- [`LICENSE`](LICENSE) 				The copyright license (GPLv3) for the TotBlocks project.
- [`totblocks.scad`](totblocks.scad)										The source code to generate TotBlocks. See below for method documentation for `totblocks.scad`.

[^1]: Note that the *T<sup>+</sup>* and *T<sup>−</sup>* notation is used here to differentiate between the two types of T modules. 
 However, the *T<sup>+</sup>* and *T<sup>−</sup>* notation actually corresponds to the orientation of the *T* modules (apices pointing up = <sup>+</sup>, down = <sup>−</sup>) rather than the modules themselves.

# Bill of materials

## Mica group (2:1 phyllosilicates)

- 4× oblock-m5-plus
- 4× tblock-n2-plus
- 4× tblock-n2-minus
- 2× single-octahedron
- 2× single-octahedron-clips
- 2× mica-connector

## Pyroxene group

### Clinopyroxene

- 4× oblock-m2-plus
- 4× tblock-n1-plus
- 4× tblock-n1-minus

### Orthopyroxene

- 4× oblock-m5-plus
- 4× oblock-m5-minus
- 8× tblock-n2-plus
- 8× tblock-n2-minus

### Protopyroxene

- 4× oblock-m5-plus
- 4× oblock-m5-minus
- 8× tblock-n2-plus
- 8× tblock-n2-minus

## Amphibole supergroup

- 4× oblock-m5-plus
- 4× tblock-n2-plus
- 4× tblock-n2-minus

## Clinojimthompsonite

- 4× oblock-m8-plus
- 4× tblock-n3-plus
- 4× tblock-n3-minus

## Chesterite

- 2× oblock-m5-plus
- 2× oblock-m5-minus
- 4× tblock-n2-plus
- 4× tblock-n2-minus
- 2× oblock-m8-plus
- 2× oblock-m8-minus
- 4× tblock-n3-plus
- 4× tblock-n3-minus

## Palygorskite group

- 4× oblock-m5-plus
- 4× tblock-n2-plus
- 4× tblock-n2-minus

## Sepiolite group

- 2× oblock-m8-plus
- 2× oblock-m8-minus
- 4× tblock-n3-plus
- 4× tblock-n3-minus

## Kalifersite

- 4× oblock-m3-plus
- 4× tblock-n2-plus
- 4× tblock-n2-minus
- 4× oblock-m6-plus
- 4× tblock-n3-plus
- 4× tblock-n3-minus

## Brucite group

- 4× oblock-m5-plus
- 2× single-octahedron
- 2× single-octahedron-clips
- 4× brucite-connector

## Lizardite (kaolinite-serpentine group)

- 4× oblock-m5-plus
- 4× tblock-n2-plus
- 2× single-octahedron
- 2× single-octahedron-clips
- 4× lizardite-connector

## Chlorite group

- 4× oblock-m5-plus
- 2× oblock-m5-minus
- 4× tblock-n2-plus
- 4× tblock-n2-minus
- 3× single-octahedron
- 3× single-octahedron-clips
- 4× chlorite-connector

# Method documentation

## Hard-coded parameters
<!-- todo: flush this out -->
These parameters are hard-coded into the TotBlocks file, but they can be adjusted using the built-in Customizer in OpenSCAD.

### Module size parameters
`t` = the true side length of the tetrahedra in the *T* modules (default 10 mm). This will define the size of both the *T* and *O* modules, since both are geometrically related.  
`numBlocks` = periodic length of the blocks (*l* in Leung and dePolo, 202x). Note that the code currently does not support half lengths.

### Peg size parameters
`pegRadius` = radius of the horizontal and vertical pegs (default 1.8 mm).  
`pegZLength` = length of vertical pegs (Z direction) (default 2.4 mm).  
`pegYLength` = length of lengthwise pegs (Y direction) (default 5 mm).  
`pegXLength` = length of widthwise pegs (X direction) (default 5 mm).  
`pegZLowerLength` = length that the vertical pegs (Z direction) should extend (default 4.4 mm).  
`pegZRotate` = orientation of the vertical pegs (Z direction) (default 90 degrees).  
`oAdjustHexHeight` = height of the hexagonal slots (Z direction) in the O modules (default 2.6 mm).  
`tMinusCutoff` = Offset used to determine where the widthwise side of the *T* modules are cut off (default 0 mm).  
`tetBridgeHeight` = Offset used for the height of the rectangular bridges that connect the tetrahedra in the *T* modules (default 0 mm).  


### Tolerance parameters
`toleranceZ` = tolerance for the radius of the vertical pegs (Z direction) (default 0 mm).  
`tZMinusTolerance` = (deprecated) tolerance for slots in *T<sup>−</sup>* modules (slots were replaced by pegs in a newer iteration) (default 0 mm).  
`lengthTolerance` = tolerance for lengths of vertical pegs (Z direction) (default 0.2 mm).  
`SlotXHeightTolerance` = extends the height (Z direction) for the widthwise pegs (X direction) to reduce issues from sagging due to bridging (default 0.6 mm).  
`toleranceXY` = tolerance for the radius of the lengthwise and widthwise pegs (Y and X directions, respectively) (default 0 mm).  


## Constants
These values are used for internal reference (don't change them).  
`PLUS = 1` constant used to denote positive orientation.  
`MINUS = 0` constant used to denote negative orientation.  

`T_SINGLE_CHAIN = 1` constant for single-chain-width *T* modules.  
`T_DOUBLE_CHAIN = 2` constant for double-chain-width *T* modules.  
`T_TRIPLE_CHAIN = 3` constant for triple-chain-width *T* modules.  

`O_SINGLE_CHAIN = 2` constant for single-chain-width *O* modules.  
`O_DOUBLE_CHAIN = 5` constant for double-chain-width *O* modules.  
`O_TRIPLE_CHAIN = 8` constant for triple-chain-width *O* modules.  


## TotBlocks modules

	tBlock (n = 1, apex = PLUS);

Produces a *T* module of certain width and polarity.

`n` = width of module (`T_SINGLE_CHAIN` = 1, `T_DOUBLE_CHAIN` = 2, `T_TRIPLE_CHAIN` = 3)  
`apex` = direction that the tetrahedra point (`PLUS` or `MINUS`)[^1]

***

	oBlock (m = 2, apex = PLUS);

Produces an *O* module of certain width and polarity

`m` = number of *M* sites in the module (`O_SINGLE_CHAIN` = 2, `O_DOUBLE_CHAIN` = 5, `O_TRIPLE_CHAIN` = 8)  
`apex` = direction that the octahedra point (`PLUS` or `MINUS`)

***

	oBlockKalifersite (m = 3, apex = PLUS);

A temporary method for producing O modules for kalifersite, which have the width-wise pegs removed. It is anticipated that this method will be deprecated and added to the `oBlock` method.
 
`m` = number of *M* sites in the module (3 = *Z*<sub>3</sub> module (double chain), 6 = *Z*<sub>6</sub> module (triple chain))  
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

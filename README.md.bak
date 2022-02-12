# Introduction
TotBlocks are a series of 3D-printed mineral building blocks for constructing the crystal structures of biopyribole-palysepiole minerals.

[![DOI](https://zenodo.org/badge/398404495.svg)](https://zenodo.org/badge/latestdoi/398404495)

How do I 3D print TotBlocks?
We are currently working on a tutorial video for 3D printing TotBlocks.
The 3D models are available as *.3mf (Prusaslicer project files) and *.stl files for 3D printing. 
Note that the *.3mf files include the positions for support enforcers for O modules (oblock), 
whereas for *.stl files the support enforcer (stl/oblock/oblock-support-enforcer) has to be added for the overhanging horizontal pegs of the O modules.


# File contents:

- 'stl/'					All the *.stl files can be found in this folder.
  -	'connectors/'			Hexagonal pegs used to vertically connect T-O-T sheets for layered minerals.
	- 'brucite-connector.stl'		For brucite structure
	- 'chlorite-connector.stl'		For chlorite structure
	- 'lizardite-connector.stl'	For lizardite (kaolinite-serpentine group) structure
	- mica-connector.stl			For mica (2:1 phyllosilicate) structure
	
		dual/				3D models used for the dual-colour version of TotBlocks (single chain, w = 1). 
							Each model has two parts, corresponding to two the different colours used in dual extrusion printing.
							These models should be overlain in the slicer for dual printing.
			oblock-m2-plus-dual-0.stl	O+ module, part 1
			oblock-m2-plus-dual-1.stl	O+ module, part 2
			tblock-n1-minus-dual-0.stl	T- module, part 1*
			tblock-n1-minus-dual-1.stl	T- module, part 2*
			tblock-n1-plus-dual-0.stl	T+ module, part 1*
			tblock-n1-plus-dual-1.stl	T+ module, part 2*
		
		oblock/				O modules (m = Z from Nespolo and Bouznari, 2017)
			oblock-m2-minus.stl		single chain (w = 1) O- module
			oblock-m2-plus.stl		single chain (w = 1) O+ module
			oblock-m3-plus.stl		Z3 O+ module for kalifersite
			oblock-m5-minus.stl		double chain (w = 2) O- module
			oblock-m5-plus.stl		double chain (w = 2) O+ module
			oblock-m6-plus.stl		Z6 O+ module for kalifersite
			oblock-m8-minus.stl		triple chain (w = 3) O- module
		
	
	

	LICENSE 				The copyright license (GPLv3) for the TotBlocks project.
	totblocks.scad			The source code to generate TotBlocks. See below for method documentation for totblocks.scad.

	*Note that the T+ and T- notation is used here to differentiate between the two types of T modules. 
	 Strictly speaking, the T+ and T- notation corresponds to the orientation of the T modules (apices pointing up = +, down = -) rather than the modules themselves.


# Method documentation:

## Modules

	tBlock (n = 1, apex = PLUS);

Produces a T module of certain width and polarity.

n = width of module (1 = single chain, 2 = double chain, 3 = triple chain)

apex = direction that the tetrahedra point (PLUS or MINUS)

***

	oBlock (m = 2, apex = PLUS);

Produces an O module of certain width and polarity

m = number of M sites in the module (2 = single chain, 5 = double chain, 8 = triple chain)

apex = direction that the octahedra point (PLUS or MINUS)

***

	oBlockKalifersite (m = 2, apex = PLUS);

A temporary method for producing O modules for kalifersite, which have the width-wise pegs removed. It is anticipated that this method will be deprecated and added to the oBlock method.
 
m = number of M sites in the module (2 = single chain, 5 = double chain, 8 = triple chain)

apex = direction that the octahedra point (PLUS or MINUS)


## Single octahedron pieces


	oBlockOne (apex = PLUS, pegs = true);

Produces a single octahedron piece. Note that there is no difference between PLUS and MINUS versions.

apex = direction that the octahedra point (PLUS or MINUS)

pegs = if TRUE, includes clips for the octahedra; if FALSE, does not include clips


## Peg connectors


	micaPeg ();

Produces a vertical peg for the mica-group minerals.

***

	chloriteBrucitePeg (length);

Produces a vertical peg for the chlorite and brucite groups, as well as lizardite (kaolinite-serpentine group)

length = length of peg (chlorite = CHLORITE_HEIGHT, brucite = BRUCITE_HEIGHT, lizardite = LIZARDITE_HEIGHT)


## Dual prints


	oBlockDual (apex = PLUS, dual = 0);

Produces two parts of a dual print for single-chain-width O modules.

apex = direction that the octahedra point (PLUS or MINUS)

dual = part number (0 or 1)

***

	tBlockDual2 (n = 1, apex = PLUS, dual = 0);

Produces two parts of a dual print for T modules.

n = width of module (1 = single chain, 2 = double chain, 3 = triple chain)

apex = direction that the tetrahedra point (PLUS or MINUS)

dual = part number (0 or 1)


## Quartz


quartzModule ();

Produces a quartz module.

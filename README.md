TotBlocks are a series of 3D-printed mineral building blocks for constructing the crystal structures of biopyribole-palysepiole minerals.

[![DOI](https://zenodo.org/badge/398404495.svg)](https://zenodo.org/badge/latestdoi/398404495)

How do I 3D print TotBlocks?
We are currently working on a tutorial video for 3D printing TotBlocks.
The 3D models are available as *.3mf (Prusaslicer project files) and *.stl files for 3D printing. 
Note that the *.3mf files include the positions for support enforcers for O modules (oblock), 
whereas for *.stl files the support enforcer (stl/oblock/oblock-support-enforcer) has to be added for the overhanging horizontal pegs of the O modules.

***************************
File contents:
***************************

stl/					All the *.stl files can be found in this folder.
	connectors/			Hexagonal pegs used to vertically connect T-O-T sheets for layered minerals.
		brucite-connector.stl	
		chlorite-connector.stl
		lizardite-connector.stl
		mica-connector.stl
	
	dual/				3D models used for the dual-colour version of TotBlocks.
		oblock-m2-plus-dual-0.stl
		oblock-m2-plus-dual-1.stl
		tblock-n1-minus-dual-0.stl
		tblock-n1-minus-dual-1.stl
		tblock-n1-plus-dual-0.stl
		tblock-n1-plus-dual-1.stl
		
	oblock/				O modules (m = Z from Nespolo and Bouznari, 2017)
		oblock-m2-minus.stl		single chain (w = 1) module (-)
		oblock-m2-plus.stl		single chain (w = 1) module (+)
		oblock-m3-plus.stl		for kalifersite
		oblock-m5-minus.stl		double chain (w = 2) module (-)
		oblock-m5-plus.stl		double chain (w = 2) module (+)
		oblock-m6-plus.stl		Z6 module for kalifersite
		oblock-m8-minus.stl		
		
	
	

LICENSE 				The copyright license (GPLv3) for the TotBlocks project.
totblocks.scad			The source code to generate TotBlocks. See below for method documentation for totblocks.scad.


Method documentation:

***************************
MODULES
***************************

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

***************************
SINGLE OCTAHEDRON PIECE
***************************

oBlockOne (apex = PLUS, pegs = true);

Produces a single octahedron piece. Note that there is no difference between PLUS and MINUS versions.

apex = direction that the octahedra point (PLUS or MINUS)

pegs = if TRUE, includes clips for the octahedra; if FALSE, does not include clips

***************************
PEG CONNECTORS
***************************

micaPeg ();

Produces a vertical peg for the mica-group minerals.

***

chloriteBrucitePeg (length);

Produces a vertical peg for the chlorite and brucite groups, as well as lizardite (kaolinite-serpentine group)

length = length of peg (chlorite = CHLORITE_HEIGHT, brucite = BRUCITE_HEIGHT, lizardite = LIZARDITE_HEIGHT)


***************************
DUAL PRINTS
***************************

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

***************************
QUARTZ
***************************

quartzModule ();

Produces a quartz module.

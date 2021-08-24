TotBlocks are a series of 3D-printed mineral building blocks for constructing the crystal structures of biopyribole-palysepiole minerals.

[![DOI](https://zenodo.org/badge/398404495.svg)](https://zenodo.org/badge/latestdoi/398404495)

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

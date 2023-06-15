Table of contents
* TOC
{:toc}

<!-- This is a test landing page for TotBlocks. -->

<!-- TODO: add paper link, youtube resources, printables -->

# Introduction

<iframe width="560" height="315" src="https://www.youtube.com/embed/pNsD5MDUdqU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

TotBlocks are a series of 3D-printed mineral building blocks for constructing the crystal structures of modular rock-forming minerals, including minerals of the biotite-pyroxene-amphibole (biopyribole) and palygorskite-sepiolite (palysepiole) series, as well as layered minerals of the brucite, kaolinite-serpentine, and chlorite groups. To learn more about TotBlocks, check out the video above and the papers on the design and theory of TotBlocks, as well as a case study of using TotBlocks in an undergradute mineralogy lab session.

## Useful publications and links

 - TotBlocks design and theory paper: [Leung, D.D.V. and dePolo, P.E. (2022) TotBlocks: exploring the relationships between modular rock-forming minerals with 3D-printed interlocking brick modules. _European Journal of Mineralogy_, 34, 523-538, https://doi.org/10.5194/ejm-34-523-2022.](https://ejm.copernicus.org/articles/34/523/2022/)

 - TotBlocks pedagogical case study: [Leung, D.D.V. and dePolo, P.E. (2023) GC Insights: The crystal structures behind the optical properties of minerals - a case study of using TotBlocks in an undergraduate mineralogy lab. _Geoscience Communcation_, preprint on EGUsphere, https://doi.org/10.5194/egusphere-2023-294.](https://egusphere.copernicus.org/preprints/2023/egusphere-2023-294/)

 - TotBlocks mirrored repository on Zenodo: [Leung, D.D.V. (2022) derekdvleung/totblocks: TotBlocks 2022.05 (totblocks-2022.05), Zenodo [code], https://doi.org/10.5281/zenodo.5240816.](https://zenodo.org/badge/latestdoi/398404495) 
<!-- [![DOI](https://zenodo.org/badge/398404495.svg)](https://zenodo.org/badge/latestdoi/398404495)-->

 - TotBlocks on GitHub: [https://github.com/derekdvleung/totblocks](https://github.com/derekdvleung/totblocks)

       -	If you have any questions, please start a thread in the [discussion](https://github.com/derekdvleung/totblocks/discussions)!
If you see any issues, please submit an [issue](https://github.com/derekdvleung/totblocks/issues).

# How do I 3D print TotBlocks?

The 3D models are available as \*.3mf (PrusaSlicer project files) and \*.stl files for 3D printing. 
Note that the \*.3mf files include the positions for support enforcers for *O* modules (`oblock`), 
whereas for \*.stl files the support enforcer (`stl/oblock/oblock-support-enforcer`) has to be added for the overhanging horizontal pegs of the *O* modules. 
When slicing (in PrusaSlicer), right click on the *O* module, then "add support enforcer".
It should be in the correct spot for single chain modules, but will need to be repositioned for other modules.
The support enforcer should be placed so that it covers the top widthwise pegs (these are overhangs, and thus need supports).

# Building the crystal structures

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

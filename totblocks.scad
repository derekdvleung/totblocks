/* Copyright (C) 2021 Derek Leung <dleung@laurentian.ca>
    This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3 as published by the Free Software Foundation. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

/*TODO:
-put peg holes into T modules so that M2, M4, A, and I sites can be inserted into the structure
-convert modules to include variable length parameters
-convert O module so that half lengths are possible*/

/*********************************************************************************************************

									CONSTANTS

**********************************************************************************************************/

// Colors - only works in Preview Mode
tColor = "crimson";
oColor = "yellowgreen";
oMColor = "yellow";

// Tetrahedron side length
t = 10;//10;  // tetrahedron side length
a = t/2; // tetrahedron half side length
ts = sqrt(3)/2*t; // slant height of tetrahedron
tx = t/sqrt(12); //length of line segment from base of triangle to centroid of triangle
th = sqrt(6)/3*t; // true height of tetrahedron
tCR = sqrt(6)/4*t; //circumradius of tetrahedron

factor = tCR/1.619; //the scale of the structure, assuming a Si-O bond distance of 1.619 A

echo (th/factor); // real height of tetrahedron in A
echo (oh/factor); // real height of octahedron in A

MICA_HEIGHT = 3.2*factor + 2*th;

// these minerals use vertical pegs to connect the O-O underside bonds, i.e., chloriteBrucitePeg module
CHLORITE_HEIGHT = 7.01*factor; // based on zanazzi et al (2007)
BRUCITE_HEIGHT = 4.73*factor; // based on nagai et al (2000)
LIZARDITE_HEIGHT =7.23*factor; // based on mellini (1982)

o = 2*(ts-tx);
b = o/2;
os = sqrt(3)/2*o; // slant height of octahedron face
ox = os/3;
oa = 4*ox; //apex-to-apex length of octahedron (flat)
oh = sqrt(o*o-(2*ox*2*ox)); //true height of flat-lying octahedron
oCR = o*sqrt(1/2); // double-checked bond distance of O sites

echo (oCR/factor); // bond distance of O sites

pegRadius = 1.8;//1; //radii of pegs (mm)
pegZLength = 2.4;////oh/2; //length of pegs (mm)
pegYLength = 5;//b;//b; 
pegXLength = 5;//b;
pegZLowerLength = 4.4;//2.4;// 4.4; //extends the opposite end of peg on the Z axis (mm)
pegZRotate =90;//0
echo(b);
toleranceZ = 0; //tolerance for Z peg radius
tZMinusTolerance = 0; //-0.1
lengthTolerance =0.2; //tolerance for Z peg length
slotXHeightTolerance =0.6;//extends slot for a specified Z height to reduce sagging from bridging
toleranceXY = 0;
tOffset = sqrt(3)/2*pegRadius; // vertical offset used for adding thickness to pegs
tExpand = 0;//5;//3;
tExpandHeight = 0;//th+tOffset;
tMinusCutoff = 0;
tetBridgeHeight = 0;//2.66-0.8; //2.66 to get flush edges
oAdjustHexHeight =2.6;//oh/2-pegZLength ;// 2.2;
bottomDesignHeight = 0.4;
tBaseScale = 1;//1.4; //1.2

numBlocks = 2; // this is the length of the blocks, can be modified as necessary.

extraBlocks = numBlocks-1; //number of blocks, not including base block

PLUS = 0;
MINUS = 1;

// Variable note:
// n = number of tetrahedra per basic module (T/2)
// n = 1,2,3...
// m = number of octahedra per basic module (Z)
// m = 2,5,8...
// m = 3n-1

T_SINGLE_CHAIN = 1; // single chain, n=1
T_DOUBLE_CHAIN = 2; // double chain, n=2
T_TRIPLE_CHAIN = 3; // triple chain, n=3
O_SINGLE_CHAIN = 2; // single chain, m =2
O_DOUBLE_CHAIN = 5; // double chain, m = 5
O_TRIPLE_CHAIN = 8; // double chain, m=4

/*********************************************************************************************************

									GEOMETRY AND POLYHEDRA

**********************************************************************************************************/

module tet(){
points = [[-1/sqrt(3)*a,a,0], [-1/sqrt(3)*a,-a,0], [2/sqrt(3)*a,0,0], [0,0,4/sqrt(6)*a]];
polyhedron(points, [[2,0,1], [1,0,3], [2,1,3], [3,0,2]]);
}

module tetBase(){
points = 
	[[-1/sqrt(3)*a,a,0], 
	[-1/sqrt(3)*a,-a,0], 
	[2/sqrt(3)*a,0,0], 
	[-1/sqrt(3)*a,a,-tOffset], 
	[-1/sqrt(3)*a,-a,-tOffset], 
	[2/sqrt(3)*a,0,-tOffset]];
polyhedron(points, [[0,2,1], [3,4,5],[0,1,4,3],[1,2,5,4],[2,0,3,5]]);//[0,1,4,3],[1,2,5,4],[2,0,3,5]]);
	//[[2,0,1], [4,3,5], [1,0,3,4],[2,1,4,5],[0,2,5,3]]);
}

module triPrism(radius, height){
points = 
	[[-sqrt(3)/2*radius,3/2*radius,0], 
	[-sqrt(3)/2*radius,-3/2*radius,0], 
	[sqrt(3)*radius,0,0], 
	[-sqrt(3)/2*radius,3/2*radius,height], 
	[-sqrt(3)/2*radius,-3/2*radius,height], 
	[sqrt(3)*radius,0,height]];
polyhedron(points, [[2,0,1], [4,3,5], [1,0,3,4],[2,1,4,5],[0,2,5,3]]);
}

module 2tet(){
translate([-(ts-tx),0,0])
tet();   
translate([-(ts+tx),t,0])
mirror([1,0,0])
tet();
}

module tetT(n=1){
		for (i = [1:n]){
		//mirror([1,0,0])
		translate([2*ts*(i-(i+1)%2-1),0,0])
		//if (i%2==0) // if even
		mirror([(i+1)%2,0,0])
		2tet();
	}
}

module tModule (n=1){
	slideY(2*t, extraBlocks)
		tetT(n);
}

// slides an object a distance on the x-axis and repeats the transformation a given number of times
module slideY(distance, repeats){
    for (i=[0:repeats]){
		translate([0,distance*i,0])
		children();
    }
}

// makes a flat-lying octahedron
module oct(){
    points = [
        [b,  ox,        oh],
        [0,  -(os-ox),  oh],
        [-b, ox,        oh],
        [b,  -ox,        0],
        [0,  (os-ox),  0],
        [-b, -ox,        0]];

    polyhedron(points, 
        [[2,0,1], 
        [4,0,2],
        [1,0,3],
        [3,0,4],
        [1,5,2],
        [5,1,3],
        [2,5,4],
        [3,4,5]]);
}

module mirrorX(){
    mirror([1,0,0])
    children();
    children();
}

module 5o(){
    mirrorX()
    3o();
}

module 3o(){

    translate([b,os,0])
    oct();
    translate([o,0,0])
    oct();
    oct();
}

module 2oct(){

    translate([-b,os,0])
    oct();
    translate([-o,0,0])
    oct();
}

// makes one unit of O module. 
// m = number of octahedra in one unit (i.e., Z)
// apex = direction of polyhedral apex (0 = up, 1 = down)
module octZ(m=2, apex = PLUS, oddsEvens = 0){
	translate([-o,0,0]){
	if(oddsEvens==0||oddsEvens==1){//odd
		for (i=[1:2:m]){
			translate([b*(i-1),0,0])
			mirror([0,apex,0])
			oct();
		}
	}
	if(oddsEvens ==0||oddsEvens ==2){
		for (i=[2:2:m]){
			translate([b*(i-1),os,0])
			mirror([0,apex,0])
			oct();
		}
	}
	}
}

module octZ2(z =2,  apex = PLUS){
	translate([-o,0,0]){
		if (z%2==1){
				translate([b*(z-1),0,0])
				mirror([0,apex,0])
				children();
		}
		if (z%2==0){
				translate([b*(z-1),os,0])
				mirror([0,apex,0])
				children();
		}
	}
}

//moves an object to a specified octahedron
module octZ3(column = 2, row = 1,  apex = PLUS){
	translate([-o,0,0]){
			translate([b*(column-1)*2+(row%2==0?b:0),(row-1)*t,0])
			mirror([0,apex,0])
			children();
	}
}

// makes a true O module
// m = number of octahedra in one unit (i.e., Z)
// apex = direction of polyhedral apex (0 = up, 1 = down)
module oModule(m = 2, apex = PLUS){  
	slideY(2*os, numBlocks -1)
		octZ(m, apex);
	if (numBlocks %1 ==0.5)
		#translate([0,2*os*(numBlocks-0.5),0])
		octZ(m, apex, oddsEvens=1);
}

// makes a true T-O-T module
module TOT(n=1,apex = PLUS,m=0){
	m = (m==0) ?  3*n-1 : m;
	TOTChild(n,apex,m){
		mirror([1,0,0])
		tModule(n);
		oModule(m,apex);
		tModule(n);
	}
}

module TOTChild(n=1,apex = PLUS,m=0){
	m = (m==0) ?  3*n-1 : m;
	color(tColor)
	translate([0,ox*(apex==PLUS ? 1: -1),2*th+oh])
	rotate([0,180,0])
	children(0);

	color(apex==0? oColor: oMColor)
	translate([0,0,th])
	children(1);
	
	color(tColor)
	translate([0,-ox*(apex==0 ? 1: -1),0])
	children(2);
}

// Makes protopyriboles (e.g., protoenstatite, proto-anthophyllite, proto-jimthompsonite)

module protoTO (n =1, rows = 1, columns = 1){
	for (i=[1:1:columns]){
		for (j=[1:1:rows]){
			translate([(i-1)*3*o*n,0,(j-1)*2*(th+oh)]){
				children(0);
				translate([1.5*o*n,n%2==1 ? 0:os,th+oh])
				children(1);
			}
		}
	}
}

module protopyribole(n=1, rows = 1, columns = 1, type = 0){
protoTO(n, rows, columns){
	if (type==1){
		simpTOT(n,0);
	}
	else{
		TOT(n,0);
	}
		if (type==1){
		simpTOT(n,1);
	}
	else{
		TOT(n,1);
	}
}
}

module clinoTO(){
	
}

module clinopyribole(){
	
}

module orthoTO(){
	
}

module orthopyribole(){
	
}

module clinoTT(){
	
}

module clinopalysepiole(){
	
}

module orthoTT(){
	
}

module orthosepiole(){
	
}

module pyroxeneChild(){
	translate([-1.5*o,-2*ox,-(th+oh)])
    children();
    translate([1.5*o,-2*ox,-(th+oh)])
    children();
	translate([-1.5*o,2*ox,th+oh])
    children();
    translate([1.5*o,2*ox,th+oh])
    children();
    children();
}

// the structure for palygorskite-supergroup minerals
module palygorskiteChild(){
  translate ([3*o,-2*ox,-(oh+2*th)])
children();
translate ([3*o,2*ox,oh+2*th])
children();
translate ([-3*o,-2*ox,-(oh+2*th)])
children();
translate ([-3*o,2*ox,oh+2*th])
children();
children();
}


// the structure for mica-group minerals
module mica(){
translate ([0,3*o,0])
TOT();
TOT();
}

module micaChild(){
translate ([3*o,0,0])
children();
children();
}

// the structure for amphiboles
module amphibole(){
translate ([-ox,3*o,oh+th])
TOT();
TOT();
} 

module amphiboleChild(){
translate ([3*o,ox,-(oh+th)])
children();
translate ([-3*o,ox,-(oh+th)])
children();
translate ([3*o,-ox,oh+th])
children();
translate ([-3*o,-ox,oh+th])
children();
children();
}  

// the structure for sepiolite-group minerals
module sepioliteChild(){
  translate ([4.5*o,-2*ox+t,-(oh+2*th)])
children();
translate ([4.5*o,2*ox-t,oh+2*th])
children();
translate ([-4.5*o,-2*ox+t,-(oh+2*th)])
children();
translate ([-4.5*o,2*ox-t,oh+2*th])
children();
children();
}

// the structure for clinojimthompsonite
module jimthompsoniteChild(){
  translate ([4.5*o,-2*ox,-(oh+th)])
children();
translate ([4.5*o,2*ox,(oh+th)])
children();
translate ([-4.5*o,-2*ox,-(oh+th)])
children();
translate ([-4.5*o,2*ox,(oh+th)])
children();
children();
}

/************************************************************************************************************

								SIMPLIFIED MODULES (PHASE I)
								ALSO INCLUDES COLOR

*************************************************************************************************************/

module simpT(n=1){
	color(tColor)
	hull()
	tModule(n);
}

module simpO(m=2,apex = PLUS){
	color(oColor)
	hull()
	oModule(m,apex);
}

module simpTOT(n=1, apex = PLUS, m=0){
	m = (m==0) ?  3*n-1 : m;
	TOTChild(n,apex,m){
		mirror([1,0,0])
		simpT(n);
		simpO(m,apex);
		simpT(n);
	}
}
    
/************************************************************************************************************

							PEG AND SLOT FUNCTIONS

*************************************************************************************************************/

module pegSlot(length, radius, lowerLength){
	bottomLength = lowerLength==undef?length:lowerLength;
    //rotate([0,0,90])
	translate([0,0,length-(length+bottomLength)/2])
    cylinder (h = length+bottomLength, r=radius, center = true, $fn = 6);       
} 

module pegSlotBeam(length, radius){
        union(){
    mirror([1,0,0])
    translate([radius*sqrt(3)/2,0,0])
    difference(){
    rotate([0,0,90])
    cylinder (h = 2*length, r=radius, center = true, $fn = 6);
            translate([radius,0,0])
    cube([radius*2, radius*2, length*2], center = true);
    }
     
    translate([radius*sqrt(3)/2,0,0])
    difference(){
    rotate([0,0,90])
    cylinder (h = 2*length, r=radius, center = true, $fn = 6);
            translate([radius,0,0])
    cube([radius*2, radius*2, length*2], center = true); 
    }  

cube([radius,radius, length*2], center = true);
}
} 

module pegCham(length, radius, lowerLength){
        a=0.5*(length+lowerLength); // a large enough number so that the chamfer doesn't affect the length of the peg
    //rotate([0,0,0])
    intersection(){
	pegSlot(length, radius, lowerLength);
    //cylinder (h = 2*length, r=radius, center = true, $fn = 6);
     //rotate([0,0,90])
    translate([0,0,length-a*radius])
    cylinder (h = 2*a*radius, r2 = radius/4*3, r1 = radius*(2*a+3/4), center = true, $fn = 6);
    }
    
}

module pegDoubleCham(length, radius, lowerLength){
        a=0.5*(length+lowerLength); // a large enough number so that the chamfer doesn't affect the length of the peg
    //rotate([0,0,0])
    intersection(){
	pegSlot(length, radius, lowerLength);
    //cylinder (h = 2*length, r=radius, center = true, $fn = 6);
     //rotate([0,0,90])
    translate([0,0,length-a*radius])
    cylinder (h = 2*a*radius, r2 = radius/4*3, r1 = radius*(2*a+3/4), center = true, $fn = 6);
	translate([0,0,-(lowerLength-a*radius)])
    cylinder (h = 2*a*radius, r1 = radius/4*3, r2 = radius*(2*a+3/4), center = true, $fn = 6);
    }
    
}
module slotChamZ (topCham = 1, bottomCham = 1){
   a=4; // a large enough number so that the chamfer doesn't affect the length of the peg
	slotZ(topCham, bottomCham);
	radius = pegRadius+toleranceZ;
	length = pegZLength +2*lengthTolerance;
    rotate([0,0,pegZRotate])
    union(){
	//rotate([0,0,90])
    cylinder (h = 2*length, r=radius, center = true, $fn = 6);
    //rotate([0,0,90])
		if (bottomCham ==1)
			translate([0,0,-a*radius+0.4])
			cylinder (h = 2*a*radius, r2 = radius, r1 = radius*(2*a), center = true, $fn = 6);
    }
}

module pegZ(length = pegZLength, radius = pegRadius, lowerLength = pegZLowerLength){
	rotate([0,0,pegZRotate])
    pegCham(length, radius, lowerLength);
}

module slotZ(length = pegZLength, radius = pegRadius, tol = toleranceZ, lenTol = lengthTolerance, topCham =1, bottomCham = 1){
	rotate([0,0,pegZRotate]){

	//if (topCham == 1)
		translate([0,0,length+2*lenTol + (radius+tol)/2])
	if (bottomCham ==1)
		cylinder (h = radius+tol, r1=radius+tol, r2 = 0, center = true, $fn = 6); 
    pegSlot(length+2*lenTol, radius+tol);
	//}
	//rotate([0,0,90])
    //cylinder(h = //tolerance*4, r2 = pegRadius, r1 = pegRadius+4*tolerance, $fn = 6);
}
}

module pegX(){
    rotate([0,90,0])
    rotate([0,0,90])
    pegCham(pegXLength, pegRadius,pegXLength);
    //pegCham(pegXLength, pegRadius);
}

module slotX(length = pegXLength, radius = pegRadius, tol = toleranceXY, ){
    rotate([0,90,0])
    rotate([0,0,90])
    pegSlot(length+2*tol, radius+tol);
    //pegSlot(pegXLength+2*tol, pegRadius+tol);
}

module pegY(){
    rotate([90,0,0])
    //rotate([0,0,90])
    pegCham(pegYLength, pegRadius,pegYLength);
    //pegCham(pegYLength, pegRadius);
}

module halfPegX(){

	scale([1,1.04,1])
    intersection(){
    pegX();
    translate([0,0,pegRadius*2])
    cube([pegYLength*4, pegRadius*4, pegRadius*4], center = true);
    }

}

module halfPegXMinus(){
    mirror([0,0,1])
    halfPegX();
}

module slotY(length = pegYLength, radius = pegRadius, tol = toleranceXY){
    rotate([-90,0,0])
    //rotate([0,0,90])
    pegSlot(length+2*tol, radius+tol);
    //pegSlot(pegYLength+2*tol, pegRadius+tol);
} 

module chevronSlotY(length = pegYLength, radius = pegRadius, tol = toleranceXY, height = slotXHeightTolerance){
	slotY(length, radius, tol);
	intersection(){
		//triangle bit
		translate([0,0,
			sqrt(3)*(radius+tol)*(1-tan(30))])
		rotate([0,270,90])
		cylinder (h = 2*length+4*tol, 
			r=(radius+tol), 
			center = true, $fn = 3);
		//pegSlot(pegYLength+2*tol, pegRadius+tol);
		translate([0,0,height])
		slotY(length, radius, tol);
	}
}

module chevronSlotX(length = pegYLength, radius = pegRadius, tol = toleranceXY, height = slotXHeightTolerance){
	slotX();
	intersection(){
		//triangle bit
		translate([0,0,
			sqrt(3)*(radius)*(1-tan(30))])
		rotate([0,270,0])
		cylinder (h = 2*pegYLength+4*tol, 
			r=(radius), 
			center = true, $fn = 3);
		//pegSlot(pegYLength+2*tol, pegRadius+tol);
		translate([0,0,height])
		slotX();
	}
}

module tZModulePegs(n = 1, apex){

for (i=[1:1:n]){
		for (j=[1:1:2*(extraBlocks+1)]){
				tetT2(i,j, th) pegZ();
		}
	}
}

module tZModuleSlots(n = 1, apex = PLUS){
	//slideY (2*t, extraBlocks)
	for (i=[1:1:n]){
		if (apex ==MINUS)
			for (j=[1:1:2*(extraBlocks+1)]){
					tetT2(i,j, th) slotZ(tol = tZMinusTolerance);
			}
		tetT2(i,2*(extraBlocks+1)+1, th) slotZ();
	}
}

module tYModulePegs(n = 1, apex = PLUS){
	for (i=[1:1:n]){
		if (apex == PLUS)
			{
				tetT2(i,2*(extraBlocks+1))
				translate([-tx,a,0])
				pegY();
			}
		if (apex == MINUS)
			{
				tetT2(i,1)
				translate([-tx,-a,0])
				pegY();
			}
	}
}

module tYModuleSlots(n = 1, apex = PLUS){
	for (i=[1:1:n]){
		if(apex == PLUS){
			tetT2(i,1,0)
			translate([-tx,-a,0])
			chevronSlotY();
		}
		if (apex == MINUS)
			{
				tetT2(i,2*(extraBlocks+1))
				translate([-tx,a,0])
				chevronSlotY();
			}
		}
}

module tYModuleSlotsChildren(n = 1, apex = PLUS){
	for (i=[1:1:n]){
		if(apex == PLUS){
			tetT2(i,1,0)
			translate([-tx,-a,0])
			children();
		}
		if (apex == MINUS)
			{
				tetT2(i,2*(extraBlocks+1))
				translate([-tx,a,0])
				children();
			}
		}
}

module tXModulePegs(n = 1, apex = PLUS){

		extraPeg = numBlocks%1==0.5?1:0;
		slideY(2*t, extraBlocks+extraPeg){
			translate([2*(n-1)*ts,t*(n%2==1?0:1),0])
			pegX();
		}

}

module tXModuleSlots(n = 1, apex = PLUS){

		slideY(2*t, extraBlocks){
			translate([-2*ts,t,0])
			mirror([1,0,0])
			chevronSlotX();
		}

}


module tXModuleSlotsChildren(n = 1, apex = PLUS){

		slideY(2*t, extraBlocks){
			translate([-2*ts,t,0])
			mirror([1,0,0])
			children();
		}

	if (n%2==1){
			tetT2(n,(extraBlocks+1)*2+1, 0)
			translate([ts-tx,0,0])
			children();		
		}
}


module oZPeg(m = 2, apex = PLUS){
	translate([-o,0,0])
	for(i = [1:1:m]){
		translate ([(i-1)*0.5*o,ox+(i%2)*os-apex*oa/2,oh])
		//rotate([0,0,90])
		pegZ(); 
	}
}

module oZSlot(m = 2, apex = PLUS, topCham = 1, bottomCham = 1){

	translate([-o,0,0])
	for(i = [1:1:m]){
		translate ([(i-1)*0.5*o,-ox+(i%2)*os-apex*oa,0])
		slotChamZ(topCham, bottomCham); 
	}

}

module oZSlotTop(m = 2, apex = PLUS, topCham = 1, bottomCham = 1){
	translate([-o,0,0])
	for(i = [1:1:m]){
		translate ([(i-1)*0.5*o,ox+(i%2)*os-apex*oa/2,oh])
		rotate([180,0,0])
		slotChamZ(topCham, bottomCham);
	}
}

module oXModulePegs(m=2, apex = PLUS){
	slideY(2*t, extraBlocks){
		translate([m*b-o,ox+(m+1)%2*os-apex*2*ox,oh])
		pegX();
		
		translate([m*b-o,-ox+(m+1)%2*os+apex*2*ox,0])
		halfPegX();
	}    
}

module oXModuleSlots(m=2, apex = PLUS){ 
	slideY(2*t, extraBlocks){
		translate([-3*b,ox-apex*2*ox,oh])
		slotX();
		
		translate([-3*b,-ox+apex*2*ox,0])
		chevronSlotX();
	}    
}

module oZModulePegs(m=2, apex = PLUS){
	slideY(2*t, extraBlocks){
		oZPeg(m, apex);
	}
}

module oZModuleSlots(m=2, apex = PLUS, topCham = 1, bottomCham = 1){
	
	slideY(2*t, numBlocks){
		oZSlot(m, apex, topCham, bottomCham);
		oZSlotTop(m, apex, topCham, bottomCham);
	}
	
	// if apex = plus, put slots at the front of the top face, if down, put slots at the end of the top face
	if (apex==0)
		translate([0,0,oh])
		mirror([0,0,1])
		oZSlot(m,1-apex, topCham, bottomCham);	
	else
		translate([0,2*t*(extraBlocks+1),oh])
		mirror([0,0,1])
		oZSlot(m,1-apex, topCham, bottomCham);
	//TODO: add functionality for half-length blocks
}

/****************************************************************************************************************************

								LEGO T-O-T 2.0

*****************************************************************************************************************************/

module slideZ(offset){
    translate([0,0,offset])
    children();
    children();
}

module tHull(n=1, y=2){
		for (i=[1:1:n]){
			for (j=[1:1:y]){
					hull(){
						tetT2(i,j) {
							tet();
							tetBase();
						}
						tetT2(i,j+1){
							tet();
							tetBase();
						}	
					}
			}
			if (i>1)
				for (k =[i%2:2:y]){
					hull(){
						tetT2(i-1,k+1){
							tet();
							tetBase();
						}
						tetT2(i,k+1){
							tet();
							tetBase();
						}
						}
					}
		}
}

module tetT2(i=1, j=1, height=0){
				translate([2*ts*(i%2==1?i-1:i-2),0,height])
				mirror([(i%2==1?0:1),0,0])
				translate([-ts+(j%2==1?1:-1)*tx,t*(j-1),0])
				mirror([(j%2==1?0:1),0,0])
				children();
}

module tModule2(n=1, apex = PLUS){
//difference(){
	mirror([apex==MINUS?1:0,0,0])
	difference(){
		union(){
			tYModulePegs(n,apex);
			tXModulePegs(n,apex);
			tZModulePegs(n,apex);
			//slideY(2*t, extraBlocks)
			tHull(n, numBlocks*2-1);
		}
		//translate([0,2*t*(extraBlocks+1),0])
		//tHull(n);
		tZModuleSlots(n, apex);
		
		for (i=[1:1:n]){
			for (j=[1:1:(extraBlocks+1)*2]){
					tetT2(i,j,-tOffset+bottomDesignHeight) {
					tetBase();
				}
			}
		}
		tXModuleSlots(n,apex);
		tYModuleSlots(n,apex);
		
		if (n==1){
			if (apex==PLUS)
				tPlusTextPx(0.4);
			else
				tMinusTextPx(0.4);
		}
		else if (apex==PLUS)
			for (i=[0:2:n-1])
				translate([2*ts*i,0,0])
					tPlusText(0.4);
		else
			for (i=[0:2:n-1])
				translate([2*ts*i,0,0])
					tMinusText(0.4);
	}
	
	module tPlusTextPx(extrudeHeight = 0.4){
		rotate([0,0,-60])
		translate([-t*cos(30),-a,0])
		translate([0,-5*a/6,th/6])
		rotate([atan(th/a),0,0])
		linear_extrude(extrudeHeight, center = true)
		text("T+", valign = "baseline", halign = "center", size = 5);
	}
	
	module tMinusTextPx(extrudeHeight = 0.4){
		rotate([0,0,-60])
		translate([-t*cos(30),-a,0])
		translate([0,-5*a/6,th/6])
		rotate([atan(th/a),0,0])
		linear_extrude(extrudeHeight, center = true)
		mirror([0,1,0])
		text("T−", valign = "top", halign = "center", size = 5);
	}
	
	module tPlusText(extrudeHeight = 0.4){
			translate([0,-5*a/6,th/6])
			rotate([atan(th/a),0,0])
			linear_extrude(0.4, center = true)
			text("T+", valign = "baseline", halign = "center", size = 5);
	}
	
	module tMinusText(extrudeHeight = 0.4){
		translate([0,-5*a/6,th/6])
		rotate([atan(th/a),0,0])
		linear_extrude(0.4, center = true)
		mirror([0,1,0])
		text("T−", valign = "top", halign = "center", size = 5);		
	}
}

module oModulePart(m=2, apex=0){
		if (m==2){
			if(extraBlocks!=0)
			slideY (2*t, extraBlocks-1)
			translate([0,2*os,oh])
			rotate([180,0,0])
			hull()
			octZ(m, apex);
		
			slideY(2*t, extraBlocks)
			hull()
			octZ(m, apex);
		}
		slideY(2*t, extraBlocks){
		hull()
		octZ(m, apex, oddsEvens = 1);
		hull()
		octZ(m, apex, oddsEvens = 2);
		}
}

module oModule2(m=2, apex = PLUS){
    oZModulePegs(m,apex);
    oXModulePegs(m,apex);
    difference(){
			union(){
				difference(){
					intersection(){
//						translate([0,-bottomDesignHeight/
//						sin(atan(oh/ox)),0])	
//						oModulePart(m,apex);
						translate([0,bottomDesignHeight/
						sin(atan(oh/ox)),0])	
						oModulePart(m,apex);
						translate([bottomDesignHeight/sin(atan(oh/ox))*
						sin(60),-bottomDesignHeight/sin(atan(oh/ox))*
						cos(60),0])
						oModulePart(m,apex);
						translate([-bottomDesignHeight/
						sin(atan(oh/ox))*cos(60),
						-bottomDesignHeight/sin(atan(oh/ox))*sin(60),0])	
						oModulePart(m,apex);
						translate([-bottomDesignHeight/sin(atan(oh/ox))*
						sin(60),bottomDesignHeight/sin(atan(oh/ox))*
						cos(60),0])
						oModulePart(m,apex);
						translate([bottomDesignHeight/sin(atan(oh/ox))*
						sin(60),bottomDesignHeight/sin(atan(oh/ox))*
						cos(60),0])
						oModulePart(m,apex);
						translate([0,0,-bottomDesignHeight])
						oModulePart(m,apex);
						translate([0,0,bottomDesignHeight])	
						oModulePart(m,apex);
						oModulePart(m,apex);	
					}
					
					// O Module Label
					if (m==2){
						if (apex ==0)
							oPlusTextPx(1.2);
						else
							oMinusTextPx(1.2);
					}		
					else if (apex==0)
						oPlusText(1.2);
					else
						oMinusText(1.2);
				}
			oModule(m,apex);
			}
		
		oZModuleSlots(m,apex); 
		oXModuleSlots(m,apex); 
		// O Module Label
		if (m==2){
			if (apex==0)
				oPlusTextPx(0.4);
			else
				oMinusTextPx(0.4);
		}
		else if (apex==0)
			oPlusText(0.4);
		else
			oMinusText(0.4);
	}  
	module oPlusText(extrude = 0.4){
		translate([(m-2+m%2)*b/2-o,-1.5*ox+
		ox/10*(m%2==0?-1:1),oh/2-oh/10*(m%2==0?-1:1)])
		rotate([-atan(oh/ox),0,0])

		rotate([(1-apex)*180,0,0])
		linear_extrude(extrude, center = true)
		text("O+", valign = "center", halign = "center", 
		size = 5);
	}
		module oMinusText(extrude = 0.4){
		translate([(m-2+m%2)*b/2-o,-1.5*ox+
		ox/10*(m%2==0?-0.7:1),oh/2+oh/10*(m%2==0?-0.7:1)])
		rotate([atan(oh/ox),0,0])

		rotate([(1-apex)*180,0,0])
		linear_extrude(extrude, center = true)
		text("O−", valign = "center", halign = "center", 
		size = 5);
	}
	module oPlusTextPx(extrude = 0.4){
		rotate([0,0,-30])
		translate([-1.5*ox+ox/10,0,oh/2-oh/10])
		rotate([0,atan(oh/ox),0])
		rotate([0,0,90])
		//mirror([0,1,0])
		linear_extrude(extrude, center = true)
		text("O+", valign = "center", halign = "center", size = 5);
	}
	
	module oMinusTextPx(extrude = 0.4){
		rotate([0,0,-30])
		translate([-1.5*ox+ox/10,0,oh/2+oh/10])
		rotate([0,-atan(oh/ox),0])
		rotate([180,0,90])
		//mirror([0,1,0])
		linear_extrude(extrude, center = true)
		text("O−", valign = "center", halign = "center", size = 5);
	}
}

//visualise TOT as an assembled set
module assembledTOT(){
    
    translate([2*ox+2*(extraBlocks+1)*t,0,2*th+oh+2*tOffset])
    rotate([0,180,0])
    tMinusModule2();
    translate([ox,0,th+tOffset])
    oModule2();
    tPlusModule2();
}

//print TOT pieces
module printTOT(){
    
    translate([-45,0,tOffset])
    children(0);
	children(1);
    translate([45,0,tOffset])
    children(2);
}

////Just a sheet of TOT lego blocks
//module sheetTOT(){
//translate([2*t*(extraBlocks+1),0,0])
//assembledTOT();
//assembledTOT();
//translate([0,3*o,0]){
//translate([2*t*(extraBlocks+1),0,0])
//assembledTOT();
//assembledTOT();
// 
//}
//}

//module OPX(){
//assembledTOTPx();
//translate([os-ox, 1.5*o, th+oh])
//assembledTOTMinusPx();
//translate([os-ox, -1.5*o, th+oh])
//assembledTOTMinusPx();
//translate([-(os-ox), -1.5*o, -(th+oh)])
//assembledTOTPx();
//translate([-(os-ox), 1.5*o, -(th+oh)])
//assembledTOTPx();
//}

//module printTOTPx(){
//
//translate([0,10,0])
//oModule2Px();
//translate([0,35,0])
//tPlusModule2Px();
//translate([0,55,0])
//tMinusModule2Px();
//translate([0,-10,0])
//oModule2Px();
//translate([0,-35,0])
//tPlusModule2Px();
//translate([0,-55,0])
//tMinusModule2Px();
//}

//module printTPlusMinus(){
//	
//translate([a,-20,0])
//tPlusModule2();
//translate([0,20,0])
//tMinusModule2();
//
//translate([a,-65,0])
//tPlusModule2();
//translate([0,65,0])
//tMinusModule2();
//}


/*****************************************************************************************************************************

							TotBlocks PHASE 3

****************************************************************************************************************************/

module oBlock(m=2, apex = PLUS){
	oXModulePegs(m,apex);

	difference(){

		union(){
			oModule(m,apex);
			intersection(){
				union(){
					for (j = [1+apex:numBlocks*2-1+apex])
					for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
						//bottom
						octZ3(i,j,apex)
						//translate([0,oa/2,0])
						//rotate([0,0,pegZRotate])
						translate([0,oa/2,0])
						rotate([0,0,pegZRotate])
						pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 
					}
			
					for (j = [2-apex:numBlocks*2-apex])
					for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
						//top
						octZ3(i,j,apex)
						//translate([0,oa/2,0])
						//rotate([0,0,pegZRotate])
						translate([0,-oa/2,oh])
						rotate([0,0,pegZRotate])
						pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 	
					}
				}
				
			translate([((1+m)/3-2)*ts,t*(extraBlocks+0.5),oh/2])
			cube([o*(1+m)/2,2*t*(extraBlocks+1), oh], 		center = true);
		}
	}
		oZModuleSlots(m,apex, topCham = 0, bottomCham =1);
		oXModuleSlots(m,apex);
	}
}

// Single octahedron that can be attached to O module
module oBlockOne(apex = PLUS, pegs = true){

	m=1;
	difference(){
		union(){
			octZ(m, apex);
			
			if(pegs){
				//clip-on pegs
				octZ3(1,1,apex){
				translate([b,-ox,oAdjustHexHeight/2])
				rotate([0,0,pegZRotate])
				pegSlot(length = oAdjustHexHeight/2, radius = 	pegRadius + 2*1.2 + toleranceZ);
				translate([-b,-ox,oAdjustHexHeight/2])
				rotate([0,0,pegZRotate])
				pegSlot(length = oAdjustHexHeight/2, radius = pegRadius + 2*1.2 + toleranceZ); 
				translate([b,ox,oh-oAdjustHexHeight/2])
				rotate([180,0,pegZRotate])
				pegSlot(length = oAdjustHexHeight/2, radius = pegRadius + 2*1.2 + toleranceZ); 				
				translate([-b,ox,oh-oAdjustHexHeight/2])
				rotate([180,0,pegZRotate])
				pegSlot(length = oAdjustHexHeight/2, radius = pegRadius + 2*1.2 + toleranceZ);
	
				}
		}			
		}

		octZ3(1,1,apex){
			translate([b,-ox,0])
			rotate([0,0,pegZRotate])
			pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 
			
			translate([-b,-ox,0])
			rotate([0,0,pegZRotate])
			pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 
			translate([b,ox,oh])
			rotate([180,0,pegZRotate])
			pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 				
			translate([-b,ox,oh])
			rotate([180,0,pegZRotate])
			pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ);
			translate([0,ox*2,0])
			pegX();
			translate([0,-ox*2,oh])
			pegX();
					
			//remove unwanted parts of clip
			translate([1.5*b,-os/2,0])
			cube([(pegRadius+2*1.2+toleranceZ),(pegRadius + 2*1.2+toleranceZ),2*oAdjustHexHeight+0.2], center = true);
			translate([-1.5*b,-os/2,0])
			cube([(pegRadius+2*1.2+toleranceZ),(pegRadius + 2*1.2+toleranceZ),2*oAdjustHexHeight+0.2], center = true);
			translate([-1.5*b,os/2,oh])
			cube([(pegRadius+2*1.2+toleranceZ),(pegRadius + 2*1.2+toleranceZ),2*oAdjustHexHeight+0.2], center = true);
			translate([1.5*b,os/2,oh])
			cube([(pegRadius+2*1.2+toleranceZ),(pegRadius + 2*1.2+toleranceZ),2*oAdjustHexHeight+0.2], center = true);
		}
			octZ3(1,0,apex)
				oct();
			octZ3(2,1,apex)
				oct();
			
			octZ3(0,1,apex)
				oct();
			octZ3(0,0,apex)
				oct();
			octZ3(1,2,apex)
				oct();
			octZ3(0,2,apex)
				oct();		
	}
}


// O Block for dual extrusion
module oBlockDual(apex = PLUS, dual = 0){
	m = 2;
	//oZModulePegs(m,apex);
	if(dual==1){
	oXModulePegs(m,apex);
	}

	difference(){

		union(){
				difference(){
				//octahedral blocks
				//oModule(m,apex);
					for(j = [1+dual:2:numBlocks*2])
						for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
							octZ3(i,j,apex)
							oct();
							}
					
					union(){
						for (j = [1+apex:numBlocks*2-1+apex])
							for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
								//bottom
								octZ3(i,j,apex)
								//translate([0,oa/2,0])
								//rotate([0,0,pegZRotate])
								translate([0,oa/2,0])
								rotate([0,0,pegZRotate])
								pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 
							}
			
						for (j = [2-apex:numBlocks*2-apex])
						for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
						//top
						octZ3(i,j,apex)
						//translate([0,oa/2,0])
						//rotate([0,0,pegZRotate])
						translate([0,-oa/2,oh])
						rotate([0,0,pegZRotate])
						pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 	
					}
				}		
				}
			
			intersection(){
				union(){
					for (j = [1+apex+dual:2:numBlocks*2-1+apex])
					for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
						//bottom
						octZ3(i,j,apex)
						//translate([0,oa/2,0])
						//rotate([0,0,pegZRotate])
						translate([0,oa/2,0])
						rotate([0,0,pegZRotate])
						pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 
					}
			
					for (j = [3-apex-dual:2:numBlocks*2-apex])
					for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
						//top
						octZ3(i,j,apex)
						//translate([0,oa/2,0])
						//rotate([0,0,pegZRotate])
						translate([0,-oa/2,oh])
						rotate([0,0,pegZRotate])
						pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 	
					}
				}
			translate([((1+m)/3-2)*ts,t*(extraBlocks+0.5),oh/2])
			cube([o*(1+m)/2,2*t*(extraBlocks+1), oh], 		center = true);
		}
	}

			oZModuleSlots(m,apex, topCham = 0, bottomCham =1);

		oXModuleSlots(m,apex);

	}
}

module tetOut(){
	hull(){
		translate([0,0,th-tCR])
		for(i=[1:3]){
			rotate(90*i, [(2/sqrt(3)*a+0)/2,(0+0)/2,(tCR-th+4/sqrt(6)*a+tCR-th)/2])
			mirror([(i%2==0?0:1)*1/sqrt(3)*a,0,(i%2==0?0:1)*(2/sqrt(6)*a+tCR-th)])
			
			translate([0,0,tCR-th+0.4568])
			//0.4568])//0.4568
			tetBase();
		}
		scale([tBaseScale,tBaseScale,1])
		tetBase();
	}
}

module tetBridge(){
	translate([0,ts-tx, th/2-tetBridgeHeight/2])
	cube([pegRadius, 2*(ts-tx), th-tetBridgeHeight], center = true);
}

module tBlock(n=1, apex = PLUS){
	mirror([apex,0,0]){
		tZModulePegs(n,apex);
		tYModulePegs(n,apex);
		tXModulePegs(n,apex);
		difference(){
			union(){
			intersection(){
				for (i=[1:1:n]){
					for (j=[1:1:2*(numBlocks)]){
						tetT2(i,j) {
							tetOut();
							// the vertical bridges on t blocks
							rotate ([0,0,30])
							tetBridge();
							rotate([0,0,-90])
							tetBridge();
							rotate([0,0,150])
							tetBridge();
						}
					}
					tetT2(i,apex == PLUS?1:2*numBlocks){
						
						translate([-tx,((apex == PLUS)?1:-1)*(-a+0.8),0]){
							//difference(){
								chevronSlotY(pegYLength+3, 
								pegRadius+
								0.8,toleranceXY);
								//translate([t/2,0,0])
								//cube(t, center = true);
							//}
						}
					}
				}
				
			//crops the sides to the width of the t module
			translate([(n-2)*ts,t*(extraBlocks+0.5),(th-tOffset)/2-tMinusCutoff*apex])
			cube([2*ts*n,2*t*(extraBlocks+1), th+tOffset-2*tMinusCutoff*apex], 		center = true);
			}
		}
			// slots
			tYModuleSlots(n,apex);
			tXModuleSlots(n,apex);
		}
	}
}

// T block for dual extrusion
module tBlockDual(n=1, apex = PLUS, dual = 0){
	mirror([apex,0,0]){
		if(dual ==0){
		tZModulePegs(n,apex);
		tYModulePegs(n,apex);
		tXModulePegs(n,apex);
		}
		difference(){
			union(){
			tModule(n);
			intersection(){
				for (i=[1:1:n]){
					for (j=[1:1:2*(numBlocks)]){
						tetT2(i,j) {
							if(dual == 0)
								difference(){
								tetOut();
								rotate ([0,0,30])
								tetBridge();
								rotate([0,0,-90])
								tetBridge();
								rotate([0,0,150])
								tetBridge();	
								}
							else{
							rotate ([0,0,30])
							tetBridge();
							rotate([0,0,-90])
							tetBridge();
							rotate([0,0,150])
							tetBridge();
							}
						}
					}
					// Y slot casing
					if(dual ==0){
					tetT2(i,apex == PLUS?1:2*numBlocks){
						
						translate([-tx,((apex == PLUS)?1:-1)*(-a+0.8),0]){
							//difference(){
								chevronSlotY(pegYLength+3, 
								pegRadius+
								0.8,toleranceXY);
								//translate([t/2,0,0])
								//cube(t, center = true);
							//}
						}
						}
					}
					// X slot casing
					/*if(dual ==0){
					tetT2(i,apex == PLUS?1:2*numBlocks){
						
						translate([-tx,((apex == PLUS)?1:-1)*(-a+0.8),0]){
							//difference(){
								chevronSlotX(pegXLength+3, 
								pegRadius+
								0.8,toleranceXY);
								//translate([t/2,0,0])
								//cube(t, center = true);
							//}
						}
						}
					}*/
				}
				
			//crops the sides to the width of the t module
			translate([(n-2)*ts,t*(extraBlocks+0.5),(th-tOffset)/2-tMinusCutoff*apex])
			cube([2*ts*n,2*t*(extraBlocks+1), th+tOffset-2*tMinusCutoff*apex], 		center = true);
			}
			
		}

			//tZModuleSlots(n,apex);
			tYModuleSlots(n,apex);
			//tXModuleSlots(n,apex);
		
			tXModuleSlotsChildren(n,apex)
						chevronSlotX(height = slotXHeightTolerance);
		
			if(dual ==1){
			tZModulePegs(n,apex);
			tYModulePegs(n,apex);
			tXModulePegs(n,apex);
			// Y slot casing
			for (i=[1:1:n]){
				tetT2(i,apex == PLUS?1:2*numBlocks)
				translate([-tx,((apex == PLUS)?1:-1)*(-a+0.8),0])
				chevronSlotY(pegYLength+3, pegRadius+	0.8,toleranceXY);
				tModule(n);
			}
		}
		}
	}
}

module tBlockDual2(n=1, apex = PLUS, dual = 0){
	
	if (dual == 0){
		mirror([apex,0,0]){
			difference(){
			tModule(n);
			tYModuleSlots(n,apex);
			tXModuleSlots(n,apex);
			}
		}
	}
	if (dual == 1){
		difference(){
			tBlock(n,apex);
			tBlockDual2(n, apex, dual = 0);
		}
	}
}

//A temporary module to make Z3 and Z6 modules as viewed in Kalifersite - this module just has the OY pegs removed

module oBlockKalifersite(m=2, apex = PLUS){
	difference(){

		union(){
			oModule(m,apex);
			intersection(){
				union(){
					for (j = [1+apex:numBlocks*2-1+apex])
					for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
						//bottom
						octZ3(i,j,apex)
						//translate([0,oa/2,0])
						//rotate([0,0,pegZRotate])
						translate([0,oa/2,0])
						rotate([0,0,pegZRotate])
						pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 
					}
			
					for (j = [2-apex:numBlocks*2-apex])
					for (i = [1:ceil(m/2)-(j%2==0 && m%2==1?1:0)]){
						//top
						octZ3(i,j,apex)
						//translate([0,oa/2,0])
						//rotate([0,0,pegZRotate])
						translate([0,-oa/2,oh])
						rotate([0,0,pegZRotate])
						pegSlot(length = oAdjustHexHeight, radius = pegRadius + 1.2 + toleranceZ); 	
					}
				}
				translate([((1+m)/3-2)*ts,t*(extraBlocks+0.5),oh/2])
				cube([b*(m+1),2*t*(extraBlocks+1), oh], 		center = true);
		}
	}
	
	oZModuleSlots(m,apex, topCham = 0, bottomCham =1);
	//oXModuleSlots(m,apex);
	translate([-o,0,0])
	slideY(2*t, numBlocks)
		for(i = [0,m+1]){
			
			translate ([(i-1)*0.5*o,-ox+(i%2)*os-apex*oa,0])
			slotChamZ(topCham = 0, bottomCham = 1); 
			translate ([(i-1)*0.5*o,ox+(i%2)*os-apex*oa/2,oh])
			rotate([180,0,0])
			slotChamZ(topCham = 0, bottomCham = 1); 
	}
	}
}

/************************************************************

					Vertical Pegs for Layered Minerals

************************************************************/

//Pegs for mica-group minerals

module micaPeg (){
	
	rotate([90,0,0])
	pegDoubleCham(MICA_HEIGHT/2+pegZLength, pegRadius,MICA_HEIGHT/2+pegZLength);

}

//Pegs for chlorite- and brucite-group minerals, as well as lizardite (kaolinite-serpentine group)
module chloriteBrucitePeg(length){
translate ([-o/2, -ox,0])
rotate([0,0,90])
triPrism(pegRadius/sqrt(3), pegZLength+lengthTolerance);

difference(){
translate ([-o/2, -ox,length/2+pegZLength+lengthTolerance])
rotate([0,0,90])
pegCham(length/2, pegRadius,length/2);

octZ3() oct();
octZ3(1,0) oct();
octZ3(1,1) oct();

}
}



/************************************************************************
					Quartz Edition of TotBlocks
******************************************************************/

ar = 2*a/sqrt(2); // the length of the cube which encloses a tetrahedron of side length a

module tetEdge(box = ar){
	points = [[-box/2,box/2,-box/2], [box/2,-box/2,-box/2], [box/2,box/2,box/2], [-box/2,-box/2,box/2]];
	polyhedron(points, [[2,0,1], [1,0,3], [2,1,3], [3,0,2]]);
}

module tetQtz(){
	translate([ar/2+sqrt(3)/6*ar,0,0])
	rotate([0,0,90])
	children();
}

module screw(fold = 3, translation = ar, n = 1){
	translate([0,0,translation*n])
	rotate([0,0,360/fold*n])
	children();
}

module quartzScrew(start = 1, end = 6, step =1, fold = 3, translation = ar){
	for(i = [start:step:end])
	screw(fold, translation, n=i-1)
	tetQtz()
		children();
}

module tetQtzMod (){
	intersection(){
		tetEdge(box = ar+4);
		cube([ar+1,ar+1,ar+1], center = true);
	}
}

module quartzChild(){
	quartzScrew()
	children();
	
	translate([0,4*a*sin(75),0])
	quartzScrew()
	children();
	
	translate([0,-4*a*sin(75),0])
	quartzScrew()
	children();
	
	translate([-(ar+2*a*sin(75)),-(2*a*sin(75)),0])
	quartzScrew()
	children();
	
	translate([(ar+2*a*sin(75)),-(2*a*sin(75)),0])
	quartzScrew()
	children();
	
	translate([-(ar+2*a*sin(75)),2*a*sin(75),0])
	quartzScrew()
	children();
	
	translate([ar+2*a*sin(75),2*a*sin(75),0])
	quartzScrew()
	children();

}

module quartzSupport(){
		
	
	#for(i = [1,2])
	translate([0,4*a*sin(75),0])
	quartzScrew(start = i, step = 3)
	children();
	
	#for(i = [3])
	translate([0,-4*a*sin(75),0])
	quartzScrew(start = i, step = 3)
	children();

	#for(i = [2,3])	
	translate([-(ar+2*a*sin(75)),-(2*a*sin(75)),0])
	quartzScrew(start = i, step = 3)
	children();

	#for(i = [1,3])	
	translate([(ar+2*a*sin(75)),-(2*a*sin(75)),0])
	quartzScrew(start = i, step = 3)
	children();

	#for(i = [2])	
	translate([-(ar+2*a*sin(75)),2*a*sin(75),0])
	quartzScrew(start = i, step = 3)
	children();
	
	#	for(i = [1])	
	translate([ar+2*a*sin(75),2*a*sin(75),0])
	quartzScrew(start = i, step = 3)
	children();

}

// TotBlocks-style module for hexagonal quartz 
module quartzModule(){
	difference(){
		quartzScrew()
			tetQtzMod();
		
		//odds
		for (i = [0:2])
		screw(n=i){
		translate([(ar+ sqrt(3)/3*ar),0,-ar])
		rotate([0,0,240])
		translate([-(ar+ sqrt(3)/3*ar),0,0])
		quartzScrew()
			tetQtzMod();
		
		//evens
		/*translate([(ar+ sqrt(3)/3*ar),0,ar])
		rotate([0,0,120])
		translate([-(ar+ sqrt(3)/3*ar),0,0])
		quartzScrew()
			tetQtzMod();*/
			
		quartzScrew(start = 7, end = 8)
			tetQtzMod();
		}
	}
}

//multi-colour quartz to show the 6-fold screw axis
module multiColourQtz(){
	difference(){
	quartzModule();
	quartzScrew(start = 5, end= 6)
	tetQtzMod();
	}
}


/****************************************************************************************************************************

										MAIN METHOD

****************************************************************************************************************************/

// n refers to the width of the modules (w in Leung and dePolo, 202X)
// m refers to the number of M sites (Z in Nespolo and Bouznari, 2017)
//n=1;
//m = 3*n-1;

//tBlock (n=1, apex = PLUS);

//oBlock (m = 2, apex = PLUS);

//oBlockKalifersite (m = 3, apex = PLUS);

//oBlockOne (apex = MINUS, pegs = true);


//micaPeg();

//chloriteBrucitePeg (CHLORITE_HEIGHT);

//oBlockDual(apex = PLUS, dual = 1);

//tBlockDual2 (n = 1, apex = PLUS, dual = 0);

//quartzModule();




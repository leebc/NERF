/*
 *  OpenSCAD barrel library
 *  Copyright (C) 2011  Bryan Lee
 *
 *  Contains specific LEGO blocks 
 *
 */


block_width=7.8; // mm 
block_height=9.6;
stud_height=1.85;
stud_diameter=4.9;

//echo ("stud_height=", stud_height);

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module lego_block(length, width, height) {
	cube( [length * block_width, width * block_width, height * block_height]);
}

module lego_studded_block(length, width, height) {
	color("red")
	lego_block (length=length, width=width, height=height);
	for ( l = [ 0 : length-1]) 
		for ( w = [0 : width-1]) 
			translate( [l * block_width + block_width/2, w * block_width + block_width/2, block_height*height])
		color("green")
				cylinder (r=stud_diameter/2, h=stud_height);
}

module lego_cylinder1(height) {
	translate([block_width/2,block_width/2,0])
		cylinder(r=block_width/2, h=height * block_height);
}

module lego_cylinder2(height) {
	translate([block_width,block_width,0])
		cylinder(r=block_width, h=height * block_height);
}

module lego_cone1(height) {
	translate([block_width/2,block_width/2,0]){
		cylinder(r=6.48/2, h=2);
		translate([0,0,2])
			cylinder(r1=block_width/2, r2=stud_diameter/2, h= block_height-2);
		translate([0,0,block_height])
			cylinder (r=stud_diameter/2, h=stud_height);
	}
}

//------------------------------------------------

translate([-1*block_width,-2*block_width,0])
	lego_cone1(height=1);

translate([-1*block_width,-5*block_width,0])
	lego_cylinder1(height=4);

translate([-3*block_width,0,0])
	lego_cylinder2(height=1);

lego_studded_block ( length=6, width=1, height=1);

translate([0,5*block_width,0]) {
	lego_studded_block ( length=6, width=2, height=6);
}

translate([0,-5*block_width,0]) {
	lego_studded_block ( length=4, width=2, height=1);
}
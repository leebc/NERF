/*
 *  OpenSCAD LEGO library
 *  Copyright (C) 2017  Bryan Lee
 *
 *  Contains specific LEGO blocks 
 *
 */
$fn=60;

block_width=7.8; // mm 
block_height=9.6;
stud_height=1.85;
stud_diameter=4.9;
rod_diameter=3.18;

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
	cylinder(r=block_width/2, h=height * block_height);
}

module lego_cylinder2(height) {
	cylinder(r=block_width, h=height * block_height);
}

module lego_cone1(height) {
	cylinder(r=6.48/2, h=2);
	translate([0,0,2])
		cylinder(r1=block_width/2, r2=stud_diameter/2, h= block_height-2);
	translate([0,0,block_height])
		cylinder (r=stud_diameter/2, h=stud_height);
}

//  This is Technic, Pin: 32054 -- "LegoTechnic, Pin 3L with Friction Ridges Lengthwise and Stop Bush"
module lego_technic_pin_32054() {
	cylinder(r=4.42/2, h=23.9);
	cylinder(r=5.67/2, h=7.8);
	cylinder(r=7.35/2, h=1.66);
	translate([0,0,7.8-1.66])
			cylinder(r=7.35/2, h=1.66);
	
	translate([0,0,7.8])
			cylinder(r=5.93/2, h=1.66);
}

//Black Bar 6L with Stop Ring
module lego_bar_6L_w_ring() {
	cylinder(r=rod_diameter/2, h=47.8);
	translate([0,0,6.57])
		cylinder(r=4.72/2, h=3.24);
}

//------------------------------------------------

translate([20,20,0])
	lego_bar_6L_w_ring();

translate([-35,30,0])
	lego_technic_pin_32054();

translate([-1*block_width,-2*block_width,0])
	lego_cone1(height=1);

translate([-1*block_width,-5*block_width,0])
	lego_cylinder1(height=4);

translate([-3*block_width,0,0])
	lego_cylinder2(height=1);

translate([10,-10,0])
	lego_studded_block ( length=6, width=1, height=1);

translate([0,5*block_width,0]) {
	lego_studded_block ( length=6, width=2, height=6);
}

translate([0,-5*block_width,0]) {
	lego_studded_block ( length=4, width=2, height=1);
}
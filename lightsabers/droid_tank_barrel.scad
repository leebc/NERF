/*
	Barrel from Droid Tank
*/

$fn=60;

use <../LEGO-library.scad>;
// Constants:
block_width=7.8; // mm 
block_height=9.6;
stud_height=1.85;
stud_diameter=4.9;
rod_diameter=3.18;

/* Functions available from this library:
		hexagon(size, height)
		module lego_block(length, width, height)
		module lego_studded_block(length, width, height)
		module lego_cylinder1(height)
		module lego_cylinder2(height)
		module lego_cone1(height)
		lego_technic_pin_32054()
		lego_bar_6L_w_ring()
*/

// Main barrel
translate([0,0,2*block_height])
	lego_cylinder1(height=4);
translate([0,0,6*block_height])
	lego_cone1(height=1);

//barrel- narrow rod
translate([0,0,block_height*11])
	rotate([180,0,0])
	lego_bar_6L_w_ring();

//tip of barrel
translate([0,0,11*block_height+4.9])
		rotate([180,0,0])
			lego_cone1(height=1);

// Technic Pin on the bottom
translate([0,0,2*block_height])
	rotate([180,0,0])
		lego_technic_pin_32054();


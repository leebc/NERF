/*
 *  OpenSCAD barrel library
 *  Copyright (C) 2011	Bryan Lee
 *
 *  Contains elements used in the creation of NERF gun barrels 
 *  and other accessories
 *
*/

// ----------

// hexagon(size, height);		// From shapes.scad
// blowback_shield(height, radius);
// e11_cooling_fin(fin_length);


module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module blowback_shield(height, radius) {
	intersection(){
		difference(){
			cylinder(h=blowback_height, r=blowback_r, $fn=resolution);
			translate([0,0,-0.5])
				cylinder(h=blowback_height+1, r=blowback_r-2, $fn=resolution);
		}
		rotate([90,0,0])
			cylinder(h=blowback_height+1, r=blowback_r-0.5, $fn=resolution);
	}
}

// 
module e11_cooling_fin(fin_length) {
	fin_flat_h=1.5;
	fin_flat_w=10;
	fin_tall_h=fin_flat_w*5/8;
	fin_tall_w=fin_flat_w*1/3;
	fin_flat_r=fin_flat_h/2;
	fin_tall_r=fin_tall_w/2;

	color("dimgray")
	linear_extrude(height=fin_length)
	{
	// Horizontal part (flat)
		translate([fin_flat_w/2-fin_flat_r,fin_flat_r,0])
			circle(r=fin_flat_r, center=false, $fn=resolution);
		translate([fin_flat_w/-2+fin_flat_r,fin_flat_r,0])
			circle(r=fin_flat_r, center=false, $fn=resolution);
		translate([fin_flat_w/-2+fin_flat_r,0,0])
			square([fin_flat_w-2*fin_flat_r,fin_flat_h]);

	//  Vertical part (tall)
		translate([0,fin_tall_h-fin_tall_r,0])
			circle(r=fin_tall_r, center=false, $fn=resolution);
		translate([fin_tall_w/-2,0,0])
			square([fin_tall_w,fin_tall_h-fin_tall_r]);
	}
}



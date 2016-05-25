
resolution=60;
rod_outer_r=(6.4+.3)/2;
rod_height=14.35;
rod_max_length=24.12;
rod_throw_distance=rod_max_length-rod_height;
rod_grove_height=5.44;
rod_grove_width=2.4;
rod_grove_depth=0.5;

tube_outer_r=(12.13+.3)/2;
tube_slot_width=4.39;
tube_slot_height=17.24 - tube_slot_width/2;
tube_length=rod_throw_distance+20;
tube_thickness=tube_outer_r-rod_outer_r;

handle_shaft_outer_r=tube_outer_r+5;
handle_shaft_length=tube_length+20;

handle_knob_outer_r1=handle_shaft_outer_r;
handle_knob_outer_r2=handle_shaft_outer_r*2;
handle_knob_height=15;

screw_r=(2.5-0.5)/2;
screw_length=10;
screw_head_r=5.5/2;
screw_z_height=tube_length+rod_grove_height-2*screw_r;

hex_nut_cross=5;
hex_nut_thickness=2.5;

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}



echo("rod_outer_r: ",rod_outer_r, "rod_height: ",rod_height, "rod_max_length: ",rod_max_length, "rod_throw_distance: ",rod_throw_distance);
echo("tube_outer_r: ",tube_outer_r, "tube_slot_width: ",tube_slot_width, "tube_slot_height: ",tube_slot_height, "tube_lenght: ",tube_length, "tube_thickness: ",tube_thickness);


difference()  {
	union()	{
		translate([0,0,0.001])
			cylinder(r=handle_shaft_outer_r,h=handle_shaft_length,$fn=resolution);

		translate([0,0,screw_z_height+screw_head_r+2])
			  // WAS:  handle_shaft_length-handle_knob_height+5])
			cylinder(r1=handle_knob_outer_r1,r2=handle_knob_outer_r2, h=handle_knob_height,$fn=resolution);
	}

	union()	{	// !!!  Prefix this line with a ! to just render the shaft !!!

		difference()  {
			cylinder(r=tube_outer_r,h=tube_length,$fn=resolution);
		
			translate([rod_outer_r,tube_slot_width/-2,tube_length-tube_slot_height])	
				color("green")
				cube([tube_thickness,tube_slot_width,tube_slot_height]);

			translate([-tube_thickness-rod_outer_r,tube_slot_width/-2,tube_length-tube_slot_height])	
				color("green")
				cube([tube_thickness,tube_slot_width,tube_slot_height]);
		}

		translate([0,0,tube_length-1])
			cylinder(r=rod_outer_r,h=rod_height+1,$fn=resolution);

		rotate([0,0,45])
			translate([rod_outer_r-rod_grove_depth,rod_grove_width/-2,tube_length]) 
				color("red")
				cube([0.5,rod_grove_width,rod_grove_height]);

		rotate([0,0,45])
			translate([rod_outer_r,0,screw_z_height])
				color("blue")
				rotate([0,90,0])
					cylinder(r=screw_r, h=screw_length,$fn=resolution);

		rotate([0,0,45])
			translate([rod_outer_r-rod_grove_depth+hex_nut_thickness/2,0,tube_length+rod_grove_height-2*screw_r])
				color("blue")
					rotate([0,90,0])
						hexagon(hex_nut_cross,hex_nut_thickness);

//		translate([-50,-50,0])	cube([50,50,50]);

	}  // end union

}	// end difference



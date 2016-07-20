
$fn=90;

PVC_d=42.22;
PVC_circumference=PVC_d*PI;
echo ("PVC_circumference=",PVC_circumference);

half_l=236.25;
tube_l=half_l*2;//11*25;
echo("Half=",half_l,"  tube=",tube_l,"  inches=",18.9*25);
barrel_l=198;	// Length of actual internal barrel
dart_r=12.15/2;
dart_l=73;

magazine_h=dart_r*2+5;
magazine_l=dart_l+5;

vent_d=18-7;
vent_r=vent_d/2;
vent_radial_offset=PVC_circumference/4;
vent_spacing_multiplier=28/19;
echo ("vent_spacing_multiplier:  ", vent_spacing_multiplier);

drill_hole_r=vent_r;
rotate_around_barrel=30;

tip_to_vent_offset=vent_d*(29.5/18.12);  //27;
echo ("tip_to_vent_offset: ", tip_to_vent_offset);

tip_to_barrel_offset=-6.85;

module flat_barrel() {
	//  Actual barrel for reference
	%translate([-6,tip_to_barrel_offset,0]) {
		translate([-15.7/2,0,0])
			square([15.7,barrel_l]);
		translate([-29/2,6.85,0])
			square([29,7.9]);
	}
}


module tube(outer_d, inner_d, length) {
	difference(){
		cylinder(r=outer_d,h=length);
		translate([0,0,-0.1])
			cylinder(r=inner_d,h=length+0.2);
	}
}

module o_ring(outer_d, inner_d) {
		
}


difference(){
	union(){
		rotate([-90,0,0])
			tube(outer_d=10, inner_d=9, length=500);
			
	}

	union(){
	translate([0,0,-50])
		cube([100,100,100]);
	}	
}	// End Difference


$fn=20;

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

//  Actual barrel for reference
%translate([-6,tip_to_barrel_offset,0]) {
	translate([-15.7/2,0,0])
		square([15.7,barrel_l]);
	translate([-29/2,6.85,0])
		square([29,7.9]);
}
// cube([45,half_l,5]);		// This marks the half-length of th etube


difference(){
	square([PVC_circumference,tube_l]);
	union(){			// Vents
		translate([1.5*vent_r,tip_to_vent_offset+vent_r,0])
			union(){
				for (x = [0,1,2,3,4])
					for (y = [0,1,2,3,4,5,6,7,8,9])
						translate([	x*vent_radial_offset,
									y*vent_spacing_multiplier*vent_d,-1])
#							circle(r=drill_hole_r);
				for (x = [0,1,2,3])
					for (y = [0,1,2,3,4,5,6,7,8])
						translate([	x*vent_radial_offset+vent_radial_offset/2,
									y*vent_spacing_multiplier*vent_d+vent_d,-1])
#							circle(r=drill_hole_r);	
			}	// End Union
#		translate([rotate_around_barrel,tip_to_barrel_offset+barrel_l,0])  {
			translate([magazine_h/2,0,0])
				square([magazine_h,magazine_l]);
			translate([magazine_h,magazine_l+1.5*vent_r,0])
				circle(r=drill_hole_r);
		}	
#		translate([	rotate_around_barrel+PVC_circumference/2,
					tip_to_barrel_offset+barrel_l,0])  {
			hull(){
				translate([2*vent_r,0,0])
					circle(r=2*vent_r);
				square([4*vent_r,magazine_l-vent_r]);
					translate([3*vent_r,magazine_l-vent_r,0])
					circle(r=vent_r);
				translate([vent_r,magazine_l,0])
					circle(r=vent_r);
			}
%			cube([20,60.1,20]);	// Marker for ejection slot
			translate([4.5*vent_r,magazine_l+vent_r*2,0]){
#				circle(r=vent_r/2);
				translate([-vent_r/2,0,0])
#					square([vent_r,149]);
				translate([0,149,0])
					circle(r=vent_r);
			}
		}

	}	//End Union of what gets differenced
}	// End Difference


$fn=90;

PVC_d=42.22;
PVC_circumference=PVC_d*PI;
PVC_r=PVC_d/2;
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


module tube(outer_r, inner_r, length) {
	difference(){
		cylinder(r=outer_r,h=length);
		translate([0,0,-0.1])
			cylinder(r=inner_r,h=length+0.2);
	}
}


module flat_cap(outer_r, inner_r, length) {
	wall_thickness=outer_r - inner_r;
	difference(){
		cylinder(r=outer_r,h=length);
		translate([0,0,-wall_thickness])
			cylinder(r=inner_r,h=length+0.2);
	}
}

module reducer(outer_r, inner_r, reduced_r,length,end_wall) {
	wall_thickness=outer_r - inner_r;
	difference(){
		cylinder(r=outer_r,h=length+end_wall);
		union(){
			translate([0,0,-wall_thickness])
				cylinder(r=inner_r,h=length);
			cylinder(r=reduced_r,h=length+end_wall+0.2);
		}
	}
}


module o_ring(outer_r, inner_r) {
	ring_r=(outer_r - inner_r)/2;
	color("black")
		rotate_extrude(convexity = 10)
			translate([inner_r+ring_r, 0, 0])
				circle(r = ring_r);		
}


//Begin Main

translate([0,29-2,0])
	rotate([90,0,0])
			o_ring(outer_r=6, inner_r=2);

difference(){
	union(){
		rotate([-90,0,0]){
			translate([0,-3,-dart_l-5]) {
				tube(outer_r=PVC_r, inner_r=PVC_r-1, length=dart_l+5+90);
				tube(outer_r=dart_r+1, inner_r=dart_r, length=dart_l);

			translate([0,0,dart_l-5])
				reducer(outer_r=PVC_r, inner_r=dart_r, reduced_r=dart_r-1,length=3,end_wall=1);
			}

			
			translate([0,-3,90-10])
				flat_cap(outer_r=PVC_r+2, inner_r=PVC_r, length=10);

			tube(outer_r=10, inner_r=9, length=29);
			translate([0,0,20])
				reducer(outer_r=11, inner_r=10, reduced_r=5,length=10,end_wall=2);
		}
		translate([0,10,0])
			rotate([90,0,0])
				flat_cap(outer_r=11, inner_r=10, length=10);
	}

	union(){
	translate([0,-20,-50])
		cube([100,150,100]);
	}	
}	// End Difference



difference(){
	cube([3,30,6]);
	union(){
			translate([-5,23,3])
				rotate([0,90,0])
			#		cylinder(r=1, h=10, $fn=60);
			translate([-5,27,3])
				rotate([0,90,0])
			#		cylinder(r=1, h=10, $fn=60);
	}
}


translate([0,0,0])
	cube([10,3,6]);

translate([10,0,0])
	rotate([0,0,20])
		cube([3,20,6]);

#translate([3.1,18,0])
	rotate([0,0,-35])
		cube([3,10,6]);
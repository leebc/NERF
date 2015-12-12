resolution=60;          // $fn

translate([0,-30,0])
difference(){
%	cube([100,30,20]);
	union(){

//		sphere(r=1, $fn=resolution);
		cube([1,1,1]);

		translate([100-30/2,30/2,20/4])
			cylinder(r=30/2,h=10);


	}  // End union
}	// Dne difference
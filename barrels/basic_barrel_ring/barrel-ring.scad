resolution=60;

color("blue")
//		translate([x_offset, y_offset, z_offset])
	difference(){
		cylinder(h = 10, r=43/2, $fn=resolution);		//outer
		translate([0,0,-1])
			cylinder(h = 55, r=36/2, $fn=resolution);	//inner
	}


color ("orange")
difference(){
	union(){
		translate ([-7.5/2,-19,0])
			cube ( [7,11,7	]);						// small wedge, lower
		translate ([-5,8,0])
			cube ( [10,11,7	]);						// large wedge, upper
	}
	translate([0,0,-1])		
		cylinder(h=25,r=30/2,$fn=resolution);	// barrel curve
}


//	translate([x_offset , y_offset -4, z_offset + 1.5 ])
	//		rotate([90,0,0]) 
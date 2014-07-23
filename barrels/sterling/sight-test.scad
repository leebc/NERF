difference(){
	linear_extrude(height = 29.3)   import("sight-profile-1.dxf");  // MIGHT be 37

	union(){
		translate([0,11.8,15])  
			rotate([0,90,0])  {
				cylinder(r=15/2 , h=30);
				translate([-15/2,0,0])
					cube([15,15/2,30]);
			}
		rotate([5,0,0])
			cube([30,30,3]);
	}	//end union
}	  //end difference
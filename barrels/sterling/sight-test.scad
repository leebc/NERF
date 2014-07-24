resolution=60;

difference(){				// Sight guard
	translate([0,29.3/2,0])
		rotate([90,0,0])
			linear_extrude(height = 29.3) 
				import("sight-profile-1.dxf");  // MIGHT be 37
	union(){
		translate([-5,0,11.8])  
			rotate([0,90,0])  
				color("blue")	cylinder(r=15/2 , h=30, $fn=resolution);
		translate([-5,-15/2,11.8])	
			color("purple")		cube([30,15,15]);
			
	
		translate([-5,-29.3/2+1,0])
			rotate([-6,0,0])		translate([0,-30,0])
				color("green")	cube([30,30,30]);

		translate([-5,29.3/2-1,0])
			rotate([6,0,0])
				color("red") cube([30,30,30]);
	}	//end union
}	  //end difference

difference()	{				// Sight block
	translate([5,-15/2,0])
		color("brown")	cube([6,15,5]);

	translate([5+0.5+5/2,0,3])
		color("black")	cylinder(h=4, r=5/2, $fn=resolution);
}	// end difference 		(sight)


translate([5+0.5,-0.5,2])	// Sight Pin
	color("orange")		cube([5,1,11]);


// Barrel from main project
barrel_outer_d=35;
ring_inner_r=(barrel_outer_d+2)/2;
ring_outer_r=ring_inner_r+2;
barrel_length=180; 
inset_height=0;
barrel_outer_r=ring_outer_r;  
echo( "barrel_outer_r" , barrel_outer_r);

translate([20-barrel_length, 0,-barrel_outer_r + 2 ])
	rotate([0,90,0])
		difference()	{
			cylinder(h = barrel_length-inset_height, r=barrel_outer_r, $fn=resolution);
			translate([0,0,-5])
				cylinder(h = barrel_length*2, r=ring_outer_r-2, $fn=resolution);
	}
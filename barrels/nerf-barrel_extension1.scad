resolution=60;
barrel_outer_d=35;
//	barrel_outer=bore_inner_d + 4;  //What IS this for???

ring_inner_r=(barrel_outer_d+2)/2;
ring_outer_r=ring_inner_r+2;
ring_height=35;
mount_inner_r=32/2;

//  Basic mounting ring
color("blue")
//		translate([x_offset, y_offset, z_offset])
	difference(){
		cylinder(h = ring_height, r=ring_outer_r, $fn=resolution);		// outer ring
		translate([0,0,-1])
			cylinder(h = ring_height*2, r=ring_inner_r, $fn=resolution);	// minus inner barrel 
	}

// Mounting "pins"
color ("")
difference(){
	union(){
		translate ([-7.5/2,-19,0])
			cube ( [7,11,7	]);						// small wedge, lower
		translate ([-5,8,0])
			cube ( [10,11,7	]);						// large wedge, upper
	}
	translate([0,0,-1])		
		cylinder(h=25,r=mount_inner_r,$fn=resolution);	// innerbarrel curve
}


//  Barrel extension  "bore"
bore_inner_r=8;
bore_outer_r=bore_inner_r + 2;
bore_protrudes=105; //60;					// How much protrudes above mounting ring
bore_height=ring_height + bore_protrudes;		// Total bore-barrel height
bore_bottom_inset=12;				// How much of bore may go into rifle
bore_bottom_inset_outer_r=bore_inner_r + 1.5;	// What fits into rifle

difference(){
	union(){
		cylinder(h=bore_height, r=bore_outer_r,$fn=resolution);
		translate([0,0,ring_height-5])
			cylinder(h=2, r=ring_outer_r,$fn=resolution); 
	}

	translate([0,0,-5])
		cylinder(h=bore_height+10, r=bore_inner_r,$fn=resolution);
}

//  Longer, wider barrel
inset_height=40;
barrel_length=43; //53;
barrel_outer_r=ring_outer_r;   //+2;
echo ("inset_height:", inset_height, "  barrel_length", barrel_length, "  barrel_outer_r" , barrel_outer_r);

difference() {
		translate([0, 0, inset_height-5])
		difference(){
			union(){		// outer barrel + angle thing
				color ("green")										//outer barrel 
					cylinder(h = barrel_length-inset_height, r=barrel_outer_r, $fn=resolution);
				color ("red")  translate ( [0,0,-20])		//anglething
					cylinder(h = inset_height/2, r2=barrel_outer_r, r1=ring_outer_r, $fn=resolution);		
				}
			union(){
				translate([0,0,-21])
					cylinder(h = barrel_length*2, r=ring_outer_r-2, $fn=resolution);	// minus inner barrel
				difference(){			 //lower groove
					cylinder(h=1, r=barrel_outer_r+1,$fn=resolution);
					cylinder(h=3, r=barrel_outer_r-1,$fn=resolution);
				}
				translate ([0,0,95] ) 
					difference(){		// upper groove
						cylinder(h=1, r=barrel_outer_r+1,$fn=resolution);
						cylinder(h=3, r=barrel_outer_r-1,$fn=resolution);
					}
			}
		}


//subtract the vents
		
	translate([-40,0, inset_height ])  color ("yellow")
	for (z = [0,1,2,3,4,5,6,7,8])
	{
			translate ([0,0,z*10])		rotate([90,0,90]) 
				cylinder(h=80, r=2 ,$fn=20);
			translate ([0,-10,z*10])		rotate([90,0,90]) 
				cylinder(h=80, r=2 ,$fn=20);
			translate ([0,10,z*10])		rotate([90,0,90]) 
				cylinder(h=80, r=2 ,$fn=20);
	}
}


// front sight
sight_width=2;
sight_height=barrel_outer_r-bore_inner_r;
sight_length=2*sight_height;
color("purple")
//	translate([-sight_width/2,bore_inner_r,bore_height-sight_length])
	//	 	cube([sight_width,sight_height,sight_length]);


color("purple")
	translate([-sight_width/2,bore_inner_r,bore_height])
polyhedron(points = [	[0,0,0],
							[0,sight_height,0],
							[sight_width,0,0],
							[0,0,-sight_length],
							[sight_width,0,-sight_length],
							[sight_width,sight_height,0],
							[0,sight_height,-sight_length/2],
							[sight_width,sight_height,-sight_length/2] ],
							triangles = [ [0,1,6,3],[3,6,7,4],[7,5,2,4], [6,1,5,7], [0,2,4,3], [0,2,5,1]		],
							convexity = 2);




















//	additional frame box
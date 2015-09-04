resolution=60;		// $fn  
barrel_outer_d=35;
//	barrel_outer=bore_inner_d + 4;  //What IS this for???

ring_barrel_diff=1;				// Difference between ring outer and barrel outer

ring_inner_r=(barrel_outer_d+2)/2;
ring_outer_r=ring_inner_r+2;
ring_height=29;		//WAS 35
mount_inner_r=32/2;
vent_r=10/2;		// WAS 11.11/2;
vent_spacing_multiplier=2.75;
inset_height=ring_height;  //WAS  40;
barrel_length=149;
barrel_outer_r=ring_outer_r;   //+2;

bore_inner_r=barrel_outer_d/2-7.7;
bore_outer_r=bore_inner_r + 2;
max_sd3_print_height=8*2.5*10;
max_protrudes=max_sd3_print_height-ring_height;

bore_protrudes=barrel_length-2*ring_height;	// How much protrudes above mounting ring (+35)
bore_height=barrel_length;
		// WAS ring_height + bore_protrudes;		// Total bore-barrel height
bore_bottom_inset=16.2;			// How much of bore may go into rifle
bore_bottom_inset_outer_r= 35/2-7.75;   //bore_inner_r + 1.0;	// What fits into rifle

echo("Bore inner R=",bore_inner_r,", Bore inset R=", bore_bottom_inset_outer_r);

muzzle_base_true_r=38.1/2;
muzzle_multiplier=ring_outer_r / muzzle_base_true_r;
muzzle_base_r=muzzle_base_true_r * muzzle_multiplier;
muzzle_tip_r=22.5/2 * muzzle_multiplier;
muzzle_middle_r=31/2 * muzzle_multiplier;
muzzle_hex_bolt_offset=2/3*muzzle_base_r+1.25;	// WAS +0

sight_width=2;
sight_height=11;
sight_length=5;

blowback_r=22/2;
blowback_height=10.5;


module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}



//  Setup a difference for just printing the muzzle tip
difference() {
	union(){

	//  Basic mounting ring
	//color("blue")
		difference(){
			union(){			
				cylinder(h = ring_height, r=ring_outer_r - ring_barrel_diff, 
					$fn=resolution);	// outer ring
			
			//Mounting Additions
				union(){	
						// Lower round part 
						cylinder(h = ring_height/4, r=ring_outer_r+1.75, 
							$fn=resolution);

						// Shoulders at bottom of heagonal part
						translate([0,0,ring_height/4]) color("red")
							cylinder(h = ring_height/8, 
								r1=ring_outer_r+1.75, r2=ring_outer_r,
							$fn=resolution);

						//Hexagonal part and top cone
						intersection(){
							union(){
								// Middle cylinder
								cylinder(h = 7/8*ring_height, r=ring_outer_r+1.75, 
									$fn=resolution);
								// Top cone		
								// This slope should be ~30 degrees, math?
								translate([0,0,7/8*ring_height]) color("red")
									cylinder(h = ring_height/1.4, 
										r1=ring_outer_r+1.75, r2=bore_outer_r+0.5,
									$fn=resolution);
							}
						// intersects with
						color("green")
							translate([0,0,0.5*ring_height])
								hexagon(2*ring_outer_r*31/32, 1.5*ring_height+0.01);
						}	// End intersection

						// Slope above
						translate([0,0,1.25*ring_height]) color("red")
							cylinder(h = 5, 
									r1=bore_outer_r+4, r2=bore_outer_r+2,
//									r1=ring_outer_r*2/3, r2=bore_outer_r,
									$fn=resolution);
		
					} // End Mounting additions union
					
			} // End "blue" union

			union(){		// Hollow the mount ring, then core the bore
				translate([0,0,-1])
					cylinder(h = ring_height+1, r=ring_inner_r, 
								$fn=resolution);	// minus inner
				cylinder(h=bore_height+10, r=bore_inner_r,$fn=resolution);
			}
		} // End "blue" difference

	// Mounting "pins"
	color ("orange")
		difference(){
			union(){
				translate ([-7.5/2,-19,0])
					cube ( [7,11,7]);					// small wedge, lower
				translate ([-5,8,0])
					cube ( [10,11,7]);					// large wedge, upper
			}
			translate([0,0,-1])		
				cylinder(h=25,r=mount_inner_r,$fn=resolution);	// innerbarrel curve
		}






//  Barrel extension  "bore"
		echo("Max sd3 height:",max_sd3_print_height,"  max_protrudes",max_protrudes,"  bore_protrudes",bore_protrudes);
difference(){
	union(){		// Main barrel/bore
		cylinder(h=bore_height, r=bore_outer_r,$fn=resolution);

		translate([0,0,ring_height])								// Lower bridge
			cylinder(h=2, r=ring_outer_r-ring_barrel_diff,$fn=resolution); 


		// Barrel slopes
		translate([0,0,1.25*ring_height+5]) color("yellow")
			cylinder(h = barrel_length/2, r1=bore_outer_r+2, r2=bore_outer_r, $fn=resolution);

		// Hook



		// Bottom of sight
		color("green")
		translate([0,0,barrel_length-12-15-35]) color("grey")
			cylinder(h = 35, r=bore_outer_r+1, $fn=resolution);


		// Sight
!		translate([0,0,barrel_length-12-15])	{
			difference(){
				union() {
					cylinder(h = 15, r=bore_outer_r+1, $fn=resolution);
					translate([-bore_outer_r,0,0])
						cube([2*bore_outer_r,2*bore_outer_r,15]);
					translate([0,2*bore_outer_r,0])
						cylinder(h = 15, r=bore_outer_r+2, $fn=resolution);
				} //End sight union

				//Remove from the sight
				union(){
					translate([0,2*bore_outer_r,-1])
						cylinder(h = 15+2, r=bore_outer_r, $fn=resolution);
					
					
				}  // End sight difference union
			}	// end Sight difference

				// Sight Pin
				color("red")
					translate([sight_width/2,1.75*bore_outer_r,sight_height])  rotate([0,0,180])
						polyhedron(points = [   [0,0,0],
										[0,sight_height,0],
										[sight_width,0,0],
										[0,0,-sight_length],
										[sight_width,0,-sight_length],
										[sight_width,sight_height,0],
										[0,sight_height,-sight_length-1],
										[sight_width,sight_height,-sight_length-1] ],
									triangles = [ [0,6,1], [0,3,6],
													[3,7,6],[3,4,7],
													[7,2,5],[7,4,2],
													[6,5,1],[6,7,5],
													[0,2,4],[0,4,3],
													[0,5,2],[0,1,5] ],
									convexity = 9);
//				color("black")
//					translate([0,2*bore_outer_r,-1]);



		}	// End sight translate


		// Barrel tip
		translate([0,0,barrel_length-11]) color("black"){
			cylinder(h = 4, r=bore_outer_r+2, $fn=10 ); //resolution);
			translate([0,0,4])
				cylinder(h = 3, r=bore_outer_r+1, $fn=10 ); //resolution);
			translate([0,0,4+3])
				cylinder(h = 4, r=bore_outer_r+2, $fn=10 ); //resolution);
		}	// End Barrel tip translate




		
	
		}	// end union of barrel bits

	union(){		// Core it
		translate([0,0,-5])
			cylinder(h=bore_height+10, r=bore_inner_r,$fn=resolution);
			color("red")  
			translate([0,0,-5])
				difference(){			// Shave a bit so it fits in the rifle
					cylinder(h=bore_bottom_inset+5, r=bore_outer_r+1,$fn=resolution);
					cylinder(h=bore_bottom_inset+5, r=bore_bottom_inset_outer_r,$fn=resolution);
		}

	}
}


//  Longer, wider barrel
		echo ("inset_height:", inset_height, "  barrel_length", barrel_length, "  barrel_outer_r" , barrel_outer_r);

difference() {
		translate([0, 0, 0])//inset_height-5])
		*difference(){
			union(){		// outer barrel
				color ("green")										//outer barrel 
					cylinder(h = barrel_length-inset_height, r=barrel_outer_r, $fn=resolution);
				
				}
			union(){		// things that are subtracted from the barrel
				translate([0,0,-21])
					cylinder(h = barrel_length*2, r=ring_outer_r-2, $fn=resolution);	// minus inner barrel
			}
		}
	}




	// membrane that supports inset
	translate([0,0,bore_bottom_inset-0.1])  color("purple")
	        cylinder(h = 0.3, r=ring_outer_r-2.1, $fn=resolution); 

}	// end union



	union(){
		cube([90,90,1150]);
//		translate([0,0,180]) cylinder(h=152, r=50);
//		translate([0,0,-0.01]) cylinder(h=133.01, r=50);
	}
}		// difference out of everything

total_height=149;
echo("Total measured length:", total_height);
//	Measure the height
translate([0,0,0])		color("magenta")
	cylinder(r=5, h=total_height);
*translate([0,0,total_height])	color("magenta")
	cube([15,5,2]);




  include </home/leebc/.local/share/OpenSCAD/libraries/gears.scad>;


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
barrel_length=37+ring_height;
barrel_outer_r=ring_outer_r;   //+2;
barrel_tip_length=(barrel_length-ring_height)/2;			// The very tip of the barrel, may be ridged

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

dart_r=12.15/2;
dart_l=73;

handle_offset_top=44;
handle_r=28/2;
handle_length=85;
handle_ridge_h=10;
handle_ridge_w=5;
handle_ridge_d=2.25;
handle_hollow_r=dart_r-1;
handle_hollow_l=dart_l-15;

rail_grove_width=12.44;
rail_grove_height=4;
rail_strip_width=18;
rail_strip_height=2.55;

handle_flush_end=ring_height+handle_ridge_d;
hook_length=35;									// length of hook from bottom of rail
hook_width=rail_strip_width;
hook_thickness=8;

sight_width=2;
sight_height=15;
sight_length=5;
sight_inner_r=bore_inner_r;

blowback_r=22/2;
blowback_height=10.5;


module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}



//  Setup a difference for printing only a portion
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




		// Fore-End
		color("Purple")
		difference(){  
			union(){
				// Main gap block
				translate([-handle_r-+handle_ridge_d/2,-handle_offset_top,0.005])
					cube([2*handle_r+handle_ridge_d,handle_offset_top,handle_flush_end]);
				// Rail grove
				translate([-rail_grove_width/2,
							-handle_offset_top-rail_grove_height,
							0.005])
					cube([rail_grove_width,rail_grove_height,handle_flush_end]);

				translate([-rail_strip_width/2,
							-handle_offset_top-rail_grove_height-rail_strip_height,
							0.005])
					cube([rail_strip_width,rail_strip_height,handle_flush_end]);


//handle_offset_top
//handle_r=28;
//handle_length
//handle_ridge_h=10;
//handle_ridge_w=5;
///handle_ridge_d=2.25;
//handle_hollow_r=dart_r-1;
//handle_hollow_l=dart_-15;
						
			}	// End main union

			// Difference that with:
			union(){				

				// This is standard coreing for the mounting ring
				translate([0,0,-1])
					cylinder(h = ring_height+1, r=ring_inner_r, 
								$fn=resolution);	// minus inner
			}

		}	// End handle difference



		// Bottom hook
		color("LightGrey")

// hook_length=35;									// length of hook from bottom of rail
// hook_width
// hook_thickness

%		difference(){  
			union(){
//				translate([-bore_outer_r/2+1,-bore_outer_r-6,handle_flush_end])
//					cube([bore_outer_r-2,7,50]);

				// main long part
				translate([-hook_width/2,
							-handle_offset_top-hook_length+hook_thickness,
							handle_flush_end-hook_thickness])
					cube([hook_width,hook_length-hook_thickness,hook_thickness]);
				
				// Angled piece of hook
				translate([-hook_width/2,
							-handle_offset_top-hook_length+hook_thickness-2.5,
							handle_flush_end-hook_thickness])
					rotate([-15,0,0])
						cube([hook_width,bore_outer_r*2,5]);

				// rounded end on the long part
				translate([-hook_width/2,
							-handle_offset_top-hook_length,
							handle_flush_end-hook_thickness])
					intersection(){	
						cube([hook_width,hook_thickness,hook_thickness]);
						translate([0,hook_thickness,hook_thickness/2])
							rotate([0,90,0])
								cylinder(h = 30, r = hook_thickness, $fn=resolution);
					}

				// bottom curve block
				translate([-hook_width/2,
							-handle_offset_top-10-1.5,
							handle_flush_end-hook_thickness-9.9])
					difference(){
						cube([hook_width,10,10]);
						rotate([0,90,0]) translate([0,0,-1])
							cylinder(h = hook_width+2, r = 5, $fn=resolution);
					}

				// Stop block for rail
				translate([-hook_width/2,
							-handle_offset_top-5,
							handle_flush_end-hook_thickness-10])
					cube([hook_width,5,10]);

			}	// End union
			union(){
//  Difference out of bottom hook
			}
		} // End Bottom hook "LightGrey" difference



		// Sight
		translate([0,ring_outer_r,ring_height-13])	{
			difference(){
				union() {
*					cylinder(h = 15, r=bore_outer_r+1, $fn=resolution); // moved to spring tube
					translate([-sight_inner_r,0,0])     color("red")
						cube([2*sight_inner_r,2*sight_inner_r,15]);
					translate([0,2*bore_outer_r,0])
						cylinder(h = 15, r=sight_inner_r+2, $fn=resolution);

					// Pins in sight sides
*					translate([-10.25,bore_outer_r-1,4])		color("black")
						rotate([0,90,0]){
							cylinder(h = 1, r=1, $fn=resolution);
						}
*					translate([9.25,bore_outer_r-1,4])		color("black")
						rotate([0,90,0]){
							cylinder(h = 1, r=1, $fn=resolution);
						}

				} //End sight union

				//Remove from the sight: hollow middle, 2 cubes to trim at angle
				union(){
					translate([0,2*bore_outer_r,-1])
						cylinder(h = 15+2, r=sight_inner_r, $fn=resolution);
					translate([-1.5*bore_outer_r,bore_outer_r,15])
						rotate([-6,0,0])
							cube(3*bore_outer_r);				
					translate([-1.5*bore_outer_r,bore_outer_r,-1.5*bore_outer_r-18])
						rotate([8,0,0])
							cube(3*bore_outer_r);
					translate([0,bore_outer_r+0.5,10])
						cylinder(h = 5, r=1, $fn=resolution);

				// Sight adjustment screws
*					translate([-10,bore_outer_r+2.5,7.5])		//color("black")
						rotate([0,90,0]){
							cylinder(h = 1, r=3, $fn=resolution);
							translate([0,0,1])rotate([0,0,50])
								cube([6,1,2],center=true);
						}
*					translate([9.5,bore_outer_r+2.5,7.5])		//color("black")
						rotate([0,90,0]){
							cylinder(h = 1, r=3, $fn=resolution);
							translate([0,0,0])rotate([0,0,20])
								cube([6,1,2],center=true);
						}



				}  // End sight difference union
			}	// end Sight difference

			// Wedge ramp leading up to the sight
	*		translate([-sight_inner_r+0.5,bore_outer_r-3,-7])     color("red")
				rotate([45,0,0])
						cube([2*sight_inner_r-1,11,9]);

				// Sight Pin
				color("red")
					rotate([0,0,180])
						translate([-sight_width/2,-2*bore_outer_r,sight_height/2])  
							polyhedron(points = [   [0,0,0],
										[0,sight_height,0],
										[sight_width,0,0],
										[0,0,-sight_length],
										[sight_width,0,-sight_length],
										[sight_width,sight_height,0],
										[0,sight_height,-sight_length-2],
										[sight_width,sight_height,-sight_length-2] ],
									triangles = [ [0,6,1], [0,3,6],
													[3,7,6],[3,4,7],
													[7,2,5],[7,4,2],
													[6,5,1],[6,7,5],
													[0,2,4],[0,4,3],
													[0,5,2],[0,1,5] ],
									convexity = 9);

*				color("grey")
					translate([-1/2*bore_outer_r,0,-35])
						rotate([-1,0,0])
							cube([bore_outer_r,bore_outer_r+1.5,35]);

		}	// End sight translate


		// Barrel tip
		translate([0,0,barrel_length-barrel_tip_length]) color("black"){

*				 gear(number_of_teeth,
					circular_pitch=false, diametral_pitch=false,
					pressure_angle=20, clearance = 0)		;

* involute_gear_tooth(
					pitch_radius,
					root_radius,
					base_radius,
					outer_radius,
					half_thick_angle
					);

			translate([0, 0, 0]) 
				linear_extrude(height=barrel_tip_length, center=false, convexity=10, twist=0)
					gear(number_of_teeth=70,circular_pitch=60);

*			for(i = [0 : 1 : barrel_tip_length])	//  0 to btl, increment 1
				translate([0, 0, i]) 
					gear(number_of_teeth=70,circular_pitch=60);

		}	// End Barrel tip translate		
	

		// Barrel triple lug
		translate([0,0,barrel_length-barrel_tip_length]) color("black"){
			for(i = [0,120,240])
				rotate([0,0,i])
					translate([-5/2,bore_outer_r-0.001,-barrel_tip_length*4/6])
						difference(){
							cube([5,3,barrel_tip_length/2]);
							union(){
//*								translate([-2,3,-3])om
	//								rotate([0,90,0])
//										cylinder(r=4, h=10, $fn=resolution);
								translate([-2.5,3.2,5.65])
									rotate([40,0,0])
										cube([10,10,10]);
								translate([-2.5,1,-10.25])
									rotate([20,0,0])
										cube([10,10,10]);
							}
						}	// End difference
		}
	

		}	// end union of barrel bits

	union(){		// Core it
		translate([0,0,-5])
			cylinder(h=bore_height+10, r=bore_inner_r,$fn=resolution);
		color("red")  
		translate([0,0,-5])
			difference(){			// Shave a bit so it fits in the rifle
				cylinder(h=bore_bottom_inset+5, r=bore_outer_r+1,$fn=resolution);
				cylinder(h=bore_bottom_inset+5, r=bore_bottom_inset_outer_r,$fn=resolution);	
			}	// End "difference shave a bit"


	}	// End "Core it"
}


//  Longer, wider barrel
		echo ("inset_height:", inset_height, "  barrel_length", barrel_length, "  barrel_outer_r" , barrel_outer_r);

difference() {
		translate([0, 0, 0])//inset_height-5])
		difference(){
			union(){		// outer barrel
//				color ("green")										//outer barrel 
//					cylinder(h = barrel_length-inset_height, r=barrel_outer_r, $fn=resolution);
				
				// Cylindrical outer wrap of MP5K
				color ("green")
				difference(){
					cylinder(h = handle_flush_end, r=barrel_outer_r+2, 
								$fn=resolution);	
					union(){
						// steps forward then rear
						translate([-barrel_outer_r*1.25,-bore_inner_r/2,handle_flush_end*2/5])
							cube([barrel_outer_r*2.5, barrel_outer_r*2, handle_flush_end]);

						translate([-barrel_outer_r*1.25,bore_inner_r/2,5])
							cube([barrel_outer_r*2.5, barrel_outer_r*2, handle_flush_end]);
					}
				}	// End outer wrap difference

				// This is the little piece of square plastic under the bolt
				color ("green"){
					translate([-bore_outer_r-1.5,1,0])
						cube([(bore_outer_r*2)+3, ring_outer_r, handle_flush_end*2/5]);
					cylinder(h = handle_flush_end*2/5, r=barrel_outer_r, $fn=resolution);	

				}  // End green

				// Slightly wider barrel part near the front
				color("grey")
				translate([0,0,handle_flush_end/2])
					cylinder(h = handle_flush_end/2, r=barrel_outer_r+0.5, $fn=resolution);	

				//Attachment pin (at the tower)
				color("lightgrey")
				translate([-bore_outer_r-3,barrel_outer_r-4,handle_flush_end*3/4])
					rotate([0,90,0])
						cylinder(h = (bore_outer_r*2)+6 , r=2, $fn=resolution);	

				//Attachment screws/bolts
				color("lightgrey")
				translate([-bore_outer_r-4,barrel_outer_r-4,handle_flush_end*1/4+1])
					rotate([0,90,0])
						cylinder(h = (bore_outer_r*2)+8 , r=3, $fn=resolution);	


				// Cocking tube
				translate([0,ring_outer_r,0])	
					difference(){
						union(){
							translate([0,0,ring_height-10])
								cylinder(h = 12, r=bore_outer_r+1, $fn=resolution);
							translate([0,0,ring_height-13])
								color("blue")
									cylinder(h = 3, r1=bore_outer_r, r2=bore_outer_r+1, $fn=resolution);
							cylinder(h = ring_height, r=bore_outer_r-1, $fn=resolution);
							cylinder(h = 13, r=bore_outer_r, $fn=resolution);
							translate([0,0,2])
								color("red")
									cylinder(h = 3, r1=bore_outer_r+1, 
															r2=bore_outer_r, $fn=resolution);
							cylinder(h = 2, r=bore_outer_r+1, $fn=resolution);
						}	// End union, positives spring tube
	
						union(){		// What gets differenced from the spring tube
						// Stamped dimples
							rotate([0,0,50])				//	Cocking tube cap
								translate([0,bore_outer_r+2.5,handle_flush_end*1/4+1])
									rotate([90,0,0])
										cylinder(h = 3, r=2, $fn=resolution);
							rotate([0,0,-50])
								translate([0,bore_outer_r+2.5,handle_flush_end*1/4+1])
									rotate([90,0,0])
										cylinder(h = 3, r=2, $fn=resolution);
						}
					}	//  End difference spring tube

				//	Cocking tube cap
				color("lightgrey")
				translate([0,ring_outer_r,handle_flush_end])
					difference(){
						linear_extrude(height=1, center=false, convexity=10, twist=0)				
							gear(number_of_teeth=60,circular_pitch=50);
						translate([0,0,0.5])
							difference(){
								cylinder(r=6.5, h=2, $fn=resolution);
								cylinder(r=5.5, h=2, $fn=resolution);
						}	// End mini difference
					}	// End tube cap difference


				// Cocking handle
				color("darkgrey")
				translate([bore_outer_r+3,barrel_outer_r+bore_outer_r*3/4,1])
					difference(){
						union(){
							sphere(r=5);
							rotate([0,90,30])
								translate([0,0,-5])
								cylinder(r=3.25, h=5, $fn=resolution);
						}
						union(){
							translate([-7,-7,-11])
								cube([15,15,10]);	
							translate([0,0,18])
								rotate([90,0,30])
									translate([0,0,-10])
									cylinder(r=15, h=15, $fn=resolution);
						}			
				}  // End darkgrey cocking handle translate




				// Sling attachment ring	


				}
			union(){		// things that are subtracted from the barrel
				// Core out for gun mounting
				translate([0,0,-21])
					cylinder(h =ring_height, r=ring_outer_r-2, $fn=resolution);	// minus inner barrel




			
			}
		}
	}




	// membrane that supports inset
	translate([0,0,bore_bottom_inset-0.1])  color("purple")
	        cylinder(h = 0.3, r=ring_outer_r-2.1, $fn=resolution); 

}	// end union


	union(){
*		cube([90,90,1150]);
//		translate([0,0,0]) cylinder(h=3.01+ring_height, r=80);    // h was 152
*		translate([0,0,-0.02]) cylinder(h=120, r=50);
*		translate([0,-3,120]) cube([50,25,50], center=true);

*		translate([0,0,barrel_length-12-17.5])  translate([0,2*bore_outer_r,-1])
			difference() {
						cylinder(h = 15+5, r=sight_inner_r+20, $fn=resolution);
						cylinder(h = 15+5, r=sight_inner_r, $fn=resolution);
			}
	}
}		// difference out of everything

total_height=37+ring_height;
echo("Total measured length:", total_height);
//	Measure the height
% translate([0,0,0])		color("magenta")
	cylinder(r=5, h=total_height);
*%translate([0,0,total_height])	color("magenta")
	cube([15,5,2]);

// Attempting to determine how long the barrel should be.
*translate([0,0,ring_height])	color("magenta")
	cube([35,5,2]);
*translate([0,0,55])	color("magenta")
	cube([35,5,2]);

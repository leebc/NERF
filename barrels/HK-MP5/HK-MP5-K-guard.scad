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
barrel_length=45+ring_height;				// 2016-01-31 WAS 37 set to 40? 45?
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
handle_ridge_d=4 ; 	//  WAS but needed thicker  2.25;
handle_hollow_r=dart_r-1;
handle_hollow_l=dart_l-15;

rail_grove_width=12.44;
rail_grove_height=4;
rail_strip_width=18;
rail_strip_height=2.55;

handle_flush_end=ring_height+handle_ridge_d;
hook_length=35;									// length of hook from bottom of rail
hook_width=rail_strip_width + 8;
hook_thickness=8;
hook_rail_cover_total_length=40;
hook_rail_cover_thickness=9;

sight_width=2;
sight_height=15;
sight_length=5;
sight_inner_r=bore_inner_r;

spring_tube_inner_r=bore_outer_r-3;

blowback_r=22/2;
blowback_height=10.5;


module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}



//  Setup a difference for printing only a portion
difference() {
	union(){


//  Barrel extension  "bore"
		echo("Max sd3 height:",max_sd3_print_height,"  max_protrudes",max_protrudes,"  bore_protrudes",bore_protrudes);
difference(){
	union(){		// Main piece



		// Bottom hook
		color("Grey")
// hook_length;									// length of hook from bottom of rail
// hook_width
// hook_thickness
// hook_rail_cover_total_length
// hook_rail_cover_thickness

		difference(){  
			union(){
*				translate([-bore_outer_r/2+1,-bore_outer_r-6,handle_flush_end])
					cube([bore_outer_r-2,7,50]);

				// main long part
				translate([-hook_width/2,
							-handle_offset_top-hook_length+hook_thickness,
							handle_flush_end-hook_thickness])
					cube([hook_width,hook_length-hook_thickness,hook_thickness]);
				
				// Angled piece of hook
				translate([-hook_width/2,
							-handle_offset_top-hook_length+hook_thickness-2.5 - 2.95,
							handle_flush_end-hook_thickness])
					rotate([-15,0,0])
						cube([hook_width,bore_outer_r*2,5]);

				// rounded end on the long part
				translate([-hook_width/2,
							-handle_offset_top-hook_length,
							handle_flush_end-hook_thickness])
					intersection(){	
						cube([hook_width,hook_thickness,hook_thickness+2]);
						translate([0,hook_thickness,hook_thickness/2])
							rotate([0,90,0])
								cylinder(h = 30, r = hook_thickness, $fn=resolution);
					}

				// bottom curve block
				translate([-hook_width/2,
							-handle_offset_top-10-1.5 - 2.5,
							handle_flush_end-hook_thickness-9.9])
					difference(){
						cube([hook_width,10,10]);
						rotate([0,90,0]) translate([0,0,-1])
							cylinder(h = hook_width+2, r = 5, $fn=resolution);
					}

				// Rail Cover 
				translate([-hook_width/2,
							-handle_offset_top - hook_rail_cover_thickness,
							handle_flush_end-hook_rail_cover_total_length])
					cube([hook_width,
							hook_rail_cover_thickness,
							hook_rail_cover_total_length]);

				// Rail cover curved corners
				translate([-hook_width/2+hook_rail_cover_thickness/2 +1.5,
							-handle_offset_top ,
							handle_flush_end-hook_rail_cover_total_length])
					rotate([0,0,0])
						cylinder(h = hook_rail_cover_total_length+2, r = hook_rail_cover_thickness, $fn=resolution);
				translate([hook_width/2 -hook_rail_cover_thickness/2 -1.5,
							-handle_offset_top ,
							handle_flush_end-hook_rail_cover_total_length])
					rotate([0,0,0])
						cylinder(h = hook_rail_cover_total_length+2, r = hook_rail_cover_thickness, $fn=resolution);


				// End cover cover
				translate([-hook_width/2,
							-handle_offset_top - hook_length + 3,
							handle_flush_end])
					cube([hook_width,
							handle_offset_top + hook_length,
							2]);
				translate([-(2*handle_r+handle_ridge_d)/2, //-hook_width/2,
							-handle_offset_top,
							handle_flush_end])
					cube([2*handle_r+handle_ridge_d,handle_offset_top,2]);
				
// Cylindrical outer wrap of MP5K
				color ("green")
				difference(){
					translate([0,0,handle_flush_end])
					cylinder(h = 2, r=barrel_outer_r+2, $fn=resolution);        
					union(){
						// steps forward then rear
						translate([-barrel_outer_r*1.25,-bore_inner_r/2,handle_flush_end*2/5])
							cube([barrel_outer_r*2.5, barrel_outer_r*2, handle_flush_end]);
					}
				}       // End outer wrap difference


			}	// End union
			union(){
//  Difference out of bottom hook
			}
		} // End Bottom hook "LightGrey" difference


	}	// end union of barrel bits

}




}	// end union

	union(){	// Difference out this

//  Longer, wider barrel
		echo ("inset_height:", inset_height, "  barrel_length", barrel_length, "  barrel_outer_r" , barrel_outer_r);

difference() {
		translate([0, 0, 0])//inset_height-5])
		difference(){
			union(){		// outer barrel
				
				}

			union(){		// things that are subtracted from the barrel
				// Core out for gun mounting
				translate([0,0,-0.1])
					cylinder(h =total_height, r=ring_outer_r-2, $fn=resolution);	// minus inner barrel
				// The bore again
				cylinder(h =total_height, r=bore_inner_r,$fn=resolution);

			cylinder(h = ring_height+1, r=ring_inner_r, $fn=resolution);	// minus inner
			}
		}
	}


	// Fore-End
		color("Purple")
		difference(){  
			union(){
				// Main gap block
				translate([-handle_r-+handle_ridge_d/2,-handle_offset_top,
									handle_flush_end-hook_rail_cover_total_length-0.005])
					cube([2*handle_r+handle_ridge_d,handle_offset_top,hook_rail_cover_total_length]);
				// Rail grove
				translate([-rail_grove_width/2,
							-handle_offset_top-rail_grove_height - 0.01,
							0.005 -  hook_rail_cover_total_length+handle_flush_end - 0.01])
					cube([rail_grove_width,rail_grove_height+0.02,hook_rail_cover_total_length+0.01]); 

				translate([-rail_strip_width/2,
							-handle_offset_top-rail_grove_height-rail_strip_height,
							0.005 -  hook_rail_cover_total_length+handle_flush_end - 0.01])
					cube([rail_strip_width,rail_strip_height,hook_rail_cover_total_length+0.01]);
						
			}	// End main union

			// Difference that with:
			union(){				

			}
		}	// End handle difference  (Purple)





*		cube([90,90,1150]);
//		translate([0,0,0]) cylinder(h=3.01+ring_height, r=80);    // h was 152
*		translate([0,0,-0.02]) cylinder(h=120, r=50);
*		translate([25,-25,40]) cube([50,50,80], center=true);

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

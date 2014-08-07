/*
 *  NERF barrel #4 -- Based on Volpin Props' Dracogen STV barrel extension
 *  lalalal
*/

resolution=60;		// $fn  for circle resolution

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
barrel_length=180; //53;
barrel_outer_r=ring_outer_r;   //+2;

bore_inner_r=barrel_outer_d/2-7.7;
bore_outer_r=bore_inner_r + 2;
max_sd3_print_height=8*2.5*10;
max_protrudes=max_sd3_print_height-ring_height;

bore_protrudes=barrel_length-2*ring_height;	// How much protrudes above mounting ring (+35)
bore_height=ring_height + bore_protrudes;		// Total bore-barrel height
bore_bottom_inset=16.2;			// How much of bore may go into rifle
bore_bottom_inset_outer_r= 35/2-7.75;   //bore_inner_r + 1.0;	// What fits into rifle

echo("Bore inner R=",bore_inner_r,", Bore inset R=", bore_bottom_inset_outer_r);

muzzle_base_true_r=38.1/2;
muzzle_multiplier=ring_outer_r / muzzle_base_true_r;
muzzle_base_r=muzzle_base_true_r * muzzle_multiplier;
muzzle_tip_r=22.5/2 * muzzle_multiplier;
muzzle_middle_r=31/2 * muzzle_multiplier;
muzzle_hex_bolt_offset=2/3*muzzle_base_r+1.25;	// WAS +0

module long_rounded_slot(length,width) {
	lrs_r=width/2;		// radius of the circle
	hull(){
		translate([lrs_r,0,0])
			circle(r=lrs_r, $fn=resolution);
		translate([length-lrs_r,0,0])
			circle(r=lrs_r, $fn=resolution);
	}
}
translate([barrel_outer_r,0,10])	color("purple")
	rotate([0,-90,0])
		linear_extrude(height=5)
			long_rounded_slot(60,11);
// Gap ~~ 6  or radius
// set of 3 in 11
// set of 2 in 41?


//  Screw base dimensions
//	47.86	straight for 5	jump to
//	52.67	angles for 2.7 to
//	56.37	straight for 1.5		jump to
//	61.34	angles for 2.5 to
//	63.09	straight for 5.5 
//	63.09	angles for  2 to
//	66.81	straight for 6.5 then 
//	inset ring for 1.4

// Muzzle tip dimensions
//	inser ring for 1.3
//	74.8	straight for 10
//	74.8	angle for1.8	 to
//	70.52	straight for 9.9 
//	70.52	angle for 2	to
//	64.13	then drop to
//	48.35	straight for 10.48
//	48.35	angle for 1.68	to 
//	43.2	then drop to  
//	39.18	straight for 1.5
//	39.18	angle for 3.8 to
//	33		end



//  Setup a difference for just printing the muzzle tip
difference() {
union(){

//  Basic mounting ring
color("blue")
	difference(){
		cylinder(h = ring_height, r=ring_outer_r - ring_barrel_diff, $fn=resolution);	// outer ring
		translate([0,0,-1])
			cylinder(h = ring_height*2, r=ring_inner_r, $fn=resolution);	// minus inner
	}

// Mounting "pins"
color ("")
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

		translate([0,0,bore_height])
			difference(){										// "Muzzle base"
//				cylinder(h=3, r=muzzle_base_r,$fn=resolution); 
				rotate_extrude()
					rotate([0,180,-90])
						hull()
						{
						square ([3,muzzle_base_r-1.5]);	// WAS (38.1-3)/2]);
						translate([0,muzzle_base_r-3])		// WAS (38.1-3)/2,0])
							difference()
							{
								circle(r=3, center=false,$fn=resolution);
								translate([-3,-3])		
									square([3,6]);
							}
						}
				translate([0,0,-5])	//		CORE IT!
					cylinder(h=30, r=bore_inner_r,$fn=resolution); //real_d 8.5
			}

//		translate([0,0,bore_height+3])	
//			difference(){										// "Muzzle middle"
//				cylinder(h=7.5, r=muzzle_middle_r,$fn=resolution);
//				translate([0,0,-5])
//					union(){
//						cylinder(h=30, r=bore_inner_r,$fn=resolution); //real_d 8.5
//						translate([muzzle_hex_bolt_offset,0,0])
//							cylinder(h=30, r=10/2,$fn=resolution);
//						translate([-muzzle_hex_bolt_offset,0,0])
//							cylinder(h=30, r=10/2,$fn=resolution);
//					}
//				}
		
		translate([0,0,bore_height+3])
			difference(){										// "Muzzle tip"
//				translate([1/4*muzzle_tip_r,-1,0])
					cylinder(h=6, r=muzzle_tip_r+1,$fn=resolution);
				translate([0,0,-5])
					union(){
						cylinder(h=30, r=bore_inner_r,$fn=resolution); //real_d 8.5
//						translate([muzzle_hex_bolt_offset,0,0])
//							cylinder(h=30, r=10/2,$fn=resolution);
//						translate([-muzzle_hex_bolt_offset,0,0])
//							cylinder(h=30, r=10/2,$fn=resolution);	
					}	// end union
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
		}
	}
}


//  Longer, wider barrel
		echo ("inset_height:", inset_height, "  barrel_length", barrel_length, "  barrel_outer_r" , barrel_outer_r);

difference() {
		translate([0, 0, 0])//inset_height-5])
		difference(){
			union(){		// outer barrel
				color ("green")										//outer barrel 
					cylinder(h = barrel_length-inset_height, r=barrel_outer_r, $fn=resolution);
				
				}
			union(){		// things that are subtracted form the barrel
				translate([0,0,-21])
					cylinder(h = barrel_length*2, r=ring_outer_r-2, $fn=resolution);	// minus inner barrel
			}
		}



//subtract the vents
//diff = 37.28/22.92 == 1.62
		translate([0,0,vent_r*1]) //inset_height ])  //color ("yellow")
			for (z = [0,1,2,3,4,5,6,7,8,9])
			{
				translate ([0,0,z * vent_spacing_multiplier * vent_r])	
				{
					rotate([90,0,0])
						translate([0,0,-40])
							cylinder(h=80, r=vent_r ,$fn=20);
					color("red")
					rotate([90,0,90])
						translate([0,0,-40])
							cylinder(h=80, r=vent_r ,$fn=20);
				}
			}
		translate([0,0,vent_r*1]) //inset_height ]) 
			for (z = [0,1,2,3,4,5,6,7,8])
			{
				translate ([0,0,z * vent_spacing_multiplier * vent_r + vent_r*1.5])
				{
					color("purple")
					rotate([90,0,45])
						translate([0,0,-40])
							cylinder(h=80, r=vent_r ,$fn=20);
					color("blue")
					rotate([90,0,135])
						translate([0,0,-40])
							cylinder(h=80, r=vent_r ,$fn=20);
				}	// end translate	
			}	// end for
	}



}	// end union

	union(){
//		translate([0,0,180]) cylinder(h=152, r=50);
//		translate([0,0,-0.01]) cylinder(h=133.01, r=50);
	}
}		// difference out of everything

total_height=167.5;
echo("Total measured length:", total_height);
//	Measure the height
//translate([0,0,0])		color("magenta")
//	cylinder(r=5, h=total_height);
//translate([0,0,total_height])	color("magenta")
//	cube([15,5,2]);




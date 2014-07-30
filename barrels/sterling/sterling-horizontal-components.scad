
resolution=60;		// $fn  fo
barrel_outer_d=35;
//	barrel_outer=bore_inner_d + 4;  //What IS this for???

ring_barrel_diff=1;				// Difference between rind outer and barrel outer

ring_inner_r=(barrel_outer_d+2)/2;
ring_outer_r=ring_inner_r+2;
ring_height=29;		//WAS 35
mount_inner_r=32/2;
vent_r=10/2;		// WAS 11.11/2;
vent_spacing_multiplier=2.75;
inset_height=ring_height;  //WAS  40;
barrel_length=180; //53;
barrel_outer_r=ring_outer_r;   //+2;

bore_inner_r=35/2-7.7;
bore_outer_r=bore_inner_r + 2;
max_sd3_print_height=8*2.5*10;
max_protrudes=max_sd3_print_height-ring_height;

bore_protrudes=barrel_length-2*ring_height;	// How much protrudes above mounting ring (+35)
bore_height=ring_height + bore_protrudes;		// Total bore-barrel height
bore_bottom_inset=15;	// was 12			// How much of bore may go into rifle
bore_bottom_inset_outer_r= 35/2-7.75;   //bore_inner_r + 1.0;	// What fits into rifle

echo("Bore inner R=",bore_inner_r,", Bore inset R=", bore_bottom_inset_outer_r);

muzzle_base_true_r=38.1/2;
muzzle_multiplier=ring_outer_r / muzzle_base_true_r;
muzzle_base_r=muzzle_base_true_r * muzzle_multiplier;
muzzle_tip_r=22.5/2 * muzzle_multiplier;
muzzle_middle_r=31/2 * muzzle_multiplier;
muzzle_hex_bolt_offset=2/3*muzzle_base_r;

sight_width=2;
sight_height=barrel_outer_r-bore_inner_r;
sight_length=2*sight_height;

blowback_r=22/2;
blowback_height=10.5;
module blowback_shield(height, radius) {
	intersection(){
		difference(){
			cylinder(h=blowback_height, r=blowback_r, $fn=resolution);
			translate([0,0,-0.5])
				cylinder(h=blowback_height+1, r=blowback_r-2, $fn=resolution);
		}
		rotate([90,0,0])
			cylinder(h=blowback_height+1, r=blowback_r-0.5, $fn=resolution);
	}
}



difference()	//Subtract the barrel
{
	union()		// all the bits
	{
		//  Front Sight
		//translate([0,barrel_outer_r - 2.5 ,barrel_length - ring_height - 18])		//rotate([180,-90,90])
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
//}	// End translate/rotate sight



		//  Front blowback shield
		//translate([-ring_outer_r+3,0,barrel_length-47.5])
		translate([-15,0,0])  rotate([0,0,90])
			//rotate([90,0,-90])
				blowback_shield(blowback_height,blowback_r);

		//  Rear blowback shield
		//translate([-ring_outer_r+3,0,vent_r-3.5])
		translate([-25,0,0])  rotate([0,0,90])
			//rotate([90,180,-90])
				blowback_shield(blowback_height,blowback_r);

		//  Dangly thing
		translate([-10,-20,0])
	//	translate([0,0,vent_r*1]) //inset_height ]) 
		//	for (z = [6])
		//	{
	//			translate ([0,0,z * vent_spacing_multiplier * vent_r + vent_r*1.5])
	//			{
					color("purple")
		//				rotate([90,0,45])
		//					translate([0,0,ring_inner_r-1])
					{
						cylinder(h=3, r=vent_r ,$fn=resolution);
						translate([-5/2,-vent_r,0])
							cube([5,vent_r*2,10]);
						rotate([90,0,0])		translate([0,10,-5])
						cylinder(h=10,r=3, $fn=resolution);
					}
	//			 }	// end translate	
		//	}	// end for

	}	//end union
	translate([-40,0,-barrel_outer_r+3.5])
		rotate([0,90,0])
			cylinder(h = barrel_length-inset_height, r=barrel_outer_r, $fn=resolution);
}	//end difference






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

module cooling_fin(fin_length) {
	fin_flat_h=1.5;
	fin_flat_w=10;
	fin_tall_h=fin_flat_w*5/8;
	fin_tall_w=fin_flat_w*1/3;
	fin_flat_r=fin_flat_h/2;
	fin_tall_r=fin_tall_w/2;

	color("dimgray")
	linear_extrude(height=fin_length)
	{
	// Horizontal part (flat)
		translate([fin_flat_w/2-fin_flat_r,fin_flat_r,0])
			circle(r=fin_flat_r, center=false, $fn=resolution);
		translate([fin_flat_w/-2+fin_flat_r,fin_flat_r,0])
			circle(r=fin_flat_r, center=false, $fn=resolution);
		translate([fin_flat_w/-2+fin_flat_r,0,0])
			square([fin_flat_w-2*fin_flat_r,fin_flat_h]);

	//  Vertical part (tall)
		translate([0,fin_tall_h-fin_tall_r,0])
			circle(r=fin_tall_r, center=false, $fn=resolution);
		translate([fin_tall_w/-2,0,0])
			square([fin_tall_w,fin_tall_h-fin_tall_r]);
	}
}



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

		translate([0,0,bore_height+3])	
			difference(){										// "Muzzle middle"
				cylinder(h=7.5, r=muzzle_middle_r,$fn=resolution);
				translate([0,0,-5])
					union(){
						cylinder(h=30, r=bore_inner_r,$fn=resolution); //real_d 8.5
						translate([muzzle_hex_bolt_offset,0,0])
							cylinder(h=30, r=10/2,$fn=resolution);
						translate([-muzzle_hex_bolt_offset,0,0])
							cylinder(h=30, r=10/2,$fn=resolution);
					}
				}
		
		translate([0,0,bore_height+3+7.5])
			difference(){										// "Muzzle tip"
				translate([1/4*muzzle_tip_r,-1,0])
					cylinder(h=6, r=muzzle_tip_r+1,$fn=resolution);
				translate([0,0,-5])
					union(){
						cylinder(h=30, r=bore_inner_r,$fn=resolution); //real_d 8.5
						translate([muzzle_hex_bolt_offset,0,0])
							cylinder(h=30, r=10/2,$fn=resolution);
						translate([-muzzle_hex_bolt_offset,0,0])
							cylinder(h=30, r=10/2,$fn=resolution);	
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

		// Not sure if these should be here...
		translate([0,muzzle_hex_bolt_offset-0.5,bore_height-1])	color("red")
			cylinder(h=50, r=1.85, $fn=resolution);
		translate([0,-muzzle_hex_bolt_offset+0.5,bore_height-1])	color("red")
			cylinder(h=1.1+7.5+3, r=1.85, $fn=resolution);
	}
}

//  The Muzzle Hex Bolts
for ( x = [ -muzzle_hex_bolt_offset, muzzle_hex_bolt_offset])
{
	translate([x,0,bore_height+3])
		difference(){		//HEX bolts
			cylinder(h=7, r=9/2);		
			translate([0,0,8])
				hexagon(5.5,13);
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

		// Notch for stock latch
		translate([-6/2,-ring_outer_r, 9* vent_spacing_multiplier * vent_r + vent_r*1.5])
		{
			cube([6,6,6]);
			translate([-2,-0.3,-2.5])
				cube([10,1,9]);
		}
	}

//  Front Sight
translate([0,barrel_outer_r - 2.5 ,barrel_length - ring_height - 18])		rotate([180,-90,90]){
	difference(){				// Sight guard
		translate([0,29.3/2,0])
			rotate([90,0,0])		// !!! Change Y rotation to 10 for angled sight
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

//	translate([5+0.5,-1,2])	// Sight Pin
	//	color("orange")		cube([5,2,11]);
	translate([11,1,13.9])	
		rotate([-90,0,-90])
			polyhedron(points = [	[0,0,0],
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
										[0,5,2],[0,1,5]	],
							convexity = 9);

}	// End translate/rotate sight



//  Front blowback shield
translate([-ring_outer_r+3,0,barrel_length-48.5])
	rotate([90,0,-90])			// !!! change X rotation to 80 for angled shield
		blowback_shield(blowback_height,blowback_r);

//  NO Rear blowback shield
//translate([-ring_outer_r+3,0,vent_r-3])
//	rotate([90,180,-90])
//		blowback_shield(blowback_height,blowback_r);


//  Dangly thing
	translate([0,0,vent_r*1]) //inset_height ]) 
	for (z = [6])
	{
			translate ([0,0,z * vent_spacing_multiplier * vent_r + vent_r*1.5])
			{
				color("purple")
				rotate([90,0,45])
					translate([0,0,ring_inner_r-1])
					{
						cylinder(h=3, r=vent_r ,$fn=resolution);
						translate([-5/2,-vent_r,2])
							rotate([-10,0,0])							
								cube([5,vent_r*2,10]);
						rotate([85,0,0])		translate([0,12,-5.65])
						difference()
						{
							cylinder(h=10,r=3.5, $fn=resolution);
							rotate([0,-10,-5])
								union()
							{
								translate([3,2,-1])	cube([3,3,12]);
								translate([-4,2,-1])  cube([3,3,12]);
							}
						}
					}
			 }	// end translate	
	}	// end for


//	Cooling fins
	// The 45 degree angle fins
	for ( fin_angle = [ -45, 45, 135 ] )
		rotate([0,0,fin_angle])
			translate([0,ring_outer_r-0.5,1 * vent_spacing_multiplier * vent_r - vent_r *0.2])
				cooling_fin(8 * vent_spacing_multiplier * vent_r);

	// The left, -90 degree fin
		rotate([0,0,-90])
			translate([0,ring_outer_r-0.5,1 * vent_spacing_multiplier * vent_r - vent_r*1.75])
				cooling_fin(9 * vent_spacing_multiplier * vent_r);

	// The right, +90 degree fin
		rotate([0,0,90])
			translate([0,ring_outer_r-0.5,1 * vent_spacing_multiplier * vent_r - vent_r*1.75])
				cooling_fin(8 * vent_spacing_multiplier * vent_r);

	// The top, 0 degree fin
		rotate([0,0,0])
			translate([0,ring_outer_r-0.5,1 * vent_spacing_multiplier * vent_r + vent_r])
				cooling_fin(8 * vent_spacing_multiplier * vent_r);

//	Rear top rail stub
	translate([-vent_r,ring_outer_r-2,vent_r/1])
		rotate([-10,0,0])
			cube([vent_r*2,10.5,2]);
	translate([-vent_r,ring_outer_r+7,0])
		rotate([0,0,0])
			cube([vent_r*2,2,5]);


}	// end uniion
translate([0,0,330]) cylinder(h=152, r=50);
}		// difference out of everything

total_height=167.5;
echo("Total measured length:", total_height);
//	Measure the height
//translate([0,0,0])		color("magenta")
//	cylinder(r=5, h=total_height);
//translate([0,0,total_height])	color("magenta")
//	cube([15,5,2]);






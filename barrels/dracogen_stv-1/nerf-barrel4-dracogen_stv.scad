/*
 *
 *  NERF barrel #4 -- Based on Volpin Props' Dracogen STV barrel extension
 *  
*/

resolution=60;		// $fn  for circle resolution

barrel_outer_d=35;
//	barrel_outer=bore_inner_d + 4;  //What IS this for???
ring_barrel_diff=0;				// Difference between ring outer and barrel outer

ring_inner_r=(barrel_outer_d+2)/2;
ring_outer_r=ring_inner_r+2;
ring_height=29;		//WAS 35
mount_inner_r=32/2;
vent_r=10/2;		// WAS 11.11/2;
vent_spacing_multiplier=2.75;
inset_height=ring_height;  //WAS  40;
barrel_length=185;								// WAS 152; 
barrel_outer_r=ring_outer_r;   //+2;

bore_inner_r=barrel_outer_d/2-7.7;
bore_outer_r=bore_inner_r + 2;
max_sd3_print_height=8*2.5*10;
max_protrudes=max_sd3_print_height-ring_height;

bore_protrudes=barrel_length-inset_height;	// How much protrudes above mounting ring
bore_height=ring_height + bore_protrudes;		// Total bore-barrel height
bore_bottom_inset=16.2;			// How much of bore may go into rifle
bore_bottom_inset_outer_r= 35/2-7.75;   //bore_inner_r + 1.0;	// What fits into rifle

echo( str("Bore inner R=",bore_inner_r,"; Bore inset R=", bore_bottom_inset_outer_r));

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

//  measured length = 285 overall
//  measured width = 60.7
//  scale factor = 35/60.7 = 0.57
//  rescaled length = 285 * 0.57 = 164


//	Vent dimensions
// lrs 60x11
// Gap ~~ 6  or radius
// set of 3 in 11
// set of 2 in 41?
vent_w=PI*barrel_outer_r/8;		//8;				// scaled?
vent_l=(barrel_length-8*vent_w)/3;		// WAS 40;				// scaled?
vent_3_inset=ring_height+2.5*vent_w;	

echo( str("barrel_outer_r => ",barrel_outer_r,";  barrel_length => ",barrel_length));
echo( str("vent_w=PI*barrel_outer_r/8 => ", vent_w,";  ventl=(barrel_length-8*vent_w)/3 => ",vent_l) ) ;


//  Screw base dimensions						
//	47.86	straight for 5	jump to			[
//	52.67	angles for 2.7 to				[
//	56.37	straight for 1.5		jump to		[
//	61.34	angles for 2.5 to				[
//	63.09	straight for 5.5 				[
//	63.09	angles for  2 to					[
//	66.81	straight for 6.5 then 			[
//	inset ring for 1.4						[

// Base
translate([0,0,ring_height+3])			color("red")
	scale( barrel_outer_r/66.81 )
		rotate_extrude(convexity=10, $fn=resolution)
			polygon(points=[[32,0],[47.86,0],[47.86,5],[52.67,5],[56.37,7.7],[56.37,9.2],[61.34,9.2],[63.09,11.7],[63.09,17.2],[66.81,19.2],[66.81,25.7],[32,25.7]  ]);

// Muzzle tip dimensions
//	inser ring for 1.3						[
//	74.8	straight for 10					[
//	74.8	angle for1.8	 to				[
//	70.52	straight for 9.9 				[
//	70.52	angle for 2	to					[
//	64.13	then drop to					[
//	48.35	straight for 10.48				[
//	48.35	angle for 1.68	to 				[
//	43.2	then drop to  					[
//	39.18	straight for 1.5					[
//	39.18	angle for 3.8 to				[
//	33		end								[

// Muzzle tip
translate([0,0,barrel_length])			color("red")
	scale( barrel_outer_r/74.8 )
		rotate_extrude(convexity=10, $fn=resolution)
			polygon(points=[  [0,0],[74.8,0],[74.8,10],[70.52,11.8],[70.52,21.7],[64.13,23.7],[48.35,23.7],[48.35,33.7],[43.2,35.38],[43.2,37.38],[39.18,38.88],[36,42.68],[36,0],[0,0]]);


translate([0,-0.25,ring_height+3])			color("pink")		// BORE RADIUS measury thing
;//	cube([bore_inner_r,0.5,164]);


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
		echo( str("Max sd3 height:",max_sd3_print_height,";  max_protrudes",max_protrudes,";  bore_protrudes",bore_protrudes) );
difference(){
	union(){		// Main barrel/bore
		color("black")
		cylinder(h=bore_height, r=bore_outer_r,$fn=resolution);

		translate([0,0,ring_height])								// Lower bridge
			cylinder(h=3, r=ring_outer_r-ring_barrel_diff,$fn=resolution); 


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
		echo ( str("inset_height:", inset_height, ";  barrel_length", barrel_length, ";  barrel_outer_r" , barrel_outer_r) );

difference() {
		translate([0, 0, ring_height+10.5])
		difference(){
			union(){		// outer barrel
				color ("green")										//outer barrel 
					cylinder(h = barrel_length-ring_height-10.5, r=barrel_outer_r, $fn=resolution);
				
				}
			union(){		// things that are subtracted form the barrel
				translate([0,0,-21])
					cylinder(h = barrel_length*2, r=ring_outer_r-2, $fn=resolution);	// minus inner barrel
			}
		}



//subtract the vents
// vent_l	// vent width
// vent_w	// vent width
// vent_3_inset		// How much the lowest of 3 vents is offset from the base

		for ( slot = [0,1,2]) {
			translate([0, 0, vent_3_inset + slot*vent_l + slot*vent_w/2 ])	color("purple") {
				rotate([0,-90,0])
					translate([0,0,-barrel_outer_r-5])
						linear_extrude(height=50)
							long_rounded_slot(vent_l,vent_w);
				rotate([0,-90,90])
					translate([0,0,-barrel_outer_r-5])
						linear_extrude(height=50)
							long_rounded_slot(vent_l,vent_w);
			}
		}
		for ( slot = [0,1]) {
			translate([0,0, vent_3_inset + vent_l/2 + slot*vent_l + slot*vent_w/2 ])	color("purple")
			{
				rotate([0,-90,45])
					translate([0,0,-barrel_outer_r-5])
						linear_extrude(height=50)
							long_rounded_slot(vent_l,vent_w);
				rotate([0,-90,-45])
					translate([0,0,-barrel_outer_r-5])
						linear_extrude(height=50)
							long_rounded_slot(vent_l,vent_w);
			}
		}

		// Upper grove
		translate ([0,0,barrel_length-2] ) 
					difference(){		// upper groove
						cylinder(h=1, r=barrel_outer_r+1,$fn=resolution);
						cylinder(h=3, r=barrel_outer_r-1,$fn=resolution);
					}

		// Lower grove
		translate ([0,0,ring_height+11] ) 
					difference(){		// upper groove
						cylinder(h=1, r=barrel_outer_r+1,$fn=resolution);
						cylinder(h=3, r=barrel_outer_r-1,$fn=resolution);
					}


//diff = 37.28/22.92 == 1.62
//		translate([0,0,vent_r*1]) //inset_height ])  //color ("yellow")
//			for (z = [0,1,2,3,4,5,6,7,8,9])
//			{
//				translate ([0,0,z * vent_spacing_multiplier * vent_r])	
//				{
//					rotate([90,0,0])
//						translate([0,0,-40])
//							cylinder(h=80, r=vent_r ,$fn=20);
//					color("red")
//					rotate([90,0,90])
//						translate([0,0,-40])
//							cylinder(h=80, r=vent_r ,$fn=20);
//				}
//			}
//		translate([0,0,vent_r*1]) //inset_height ]) 
//			for (z = [0,1,2,3,4,5,6,7,8])
//			{
//				translate ([0,0,z * vent_spacing_multiplier * vent_r + vent_r*1.5])
//				{
//					color("purple")
//					rotate([90,0,45])
//						translate([0,0,-40])
//							cylinder(h=80, r=vent_r ,$fn=20);
//					color("blue")
//					rotate([90,0,135])
//						translate([0,0,-40])
//							cylinder(h=80, r=vent_r ,$fn=20);
//				}	// end translate	
//			}	// end for
	}



}	// end union

	union(){
//		translate([0,0,180]) cylinder(h=152, r=50);
//		translate([0,0,-0.01]) cylinder(h=133.01, r=50);
	}
}		// difference out of everything

total_height=167.5;
echo( str("Total measured length:", total_height) );
//	Measure the height
//translate([0,0,0])		color("magenta")
//	cylinder(r=5, h=total_height);
//translate([0,0,total_height])	color("magenta")
//	cube([15,5,2]);




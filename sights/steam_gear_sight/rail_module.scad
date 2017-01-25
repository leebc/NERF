//Rail build 2

rail_top_w=18;
rail_top_h=2.87;
rail_grove_w=12.45;
rail_grove_h=3.42;

slot_top_w=18;
slot_top_h=3.3;
slot_grove_w=12.6;
slot_grove_h=3;

length=5;
cube_size=25;

module createRail ( my_length ) {
	translate([0,my_length/2,0]) {
		translate([0,0,rail_grove_h/2+0.015])  color("Red")
			cube([rail_grove_w,my_length,rail_grove_h+0.01], center=true);
		translate([0,0,rail_grove_h+rail_top_h/2])
			cube([rail_top_w,my_length,rail_top_h],center=true);
	}
}


module creatSlot ( my_length ) {
	my_length=my_length+0.001;
	translate([0,(my_length-0.0005)/2,0]) {
		translate([0,0,slot_grove_h/2+0.015])  color("Red")
			cube([slot_grove_w,my_length,slot_grove_h+0.01], center=true);
		translate([0,0,slot_grove_h+slot_top_h/2])
			cube([slot_top_w,my_length,slot_top_h],center=true);
	}
	
}

difference(){
	cube ([cube_size,length,cube_size]);
	translate([cube_size/2,0,-0.015])
		creatSlot(20);
}
translate([cube_size/2,0,cube_size-0.015])
	createRail (length);

//# Tangent bladed fan for Grammies sewing machine motor

resolution=90;
inside_r_correction=0.6;

rotor_r=42.97/2;
rotor_h=1.6;

blade_l=14.7;
blade_h=6.37-rotor_h;
blade_t=1.5;

axel_r=(5.8+inside_r_correction)/2;
hub_r=10/2 ;    // WAS axel_r+1.98/2;
hub_h=7.75;

//# Tangent bladed fan for Grammies sewing machine motor



difference()
{
	union()
		{
		cylinder(r=rotor_r, h=rotor_h, $fn=resolution);
		cylinder(r=hub_r, h=hub_h, $fn=resolution);
		}
	cylinder(r=axel_r, h=20,$fn=resolution);
}


for ( blade_num = [0,1,2,3,4,5,6,7,8,9,10,11]) {
	rotate([0,0,(360/12*blade_num)])
	translate([hub_r+1,axel_r-0,rotor_h])
		intersection(){
#			cube([blade_l, blade_t, blade_h]);

			rotate([90,0,0]) translate([blade_l-3,-blade_h-4,-3])
#				cylinder(r=blade_l, h=5, $fn=resolution*5);
		}
	}

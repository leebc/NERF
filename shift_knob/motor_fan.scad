//# Tangent bladed fan for Grammies sewing machine motor

resolution=60;
inside_r_correction=0.4;

rotor_r=42.97/2;
rotor_h=1.6;

blade_l=14.7;
blade_h=6.37-rotor_h;
blade_t=1.5;

axel_r=(5.8+inside_r_correction)/2;
bushing_r=axel_r+1.98/2;
bushing_h=6;

//# Tangent bladed fan for Grammies sewing machine motor



difference()
{
	union()
		{
		cylinder(r=rotor_r, h=rotor_h, $fn=resolution);
		cylinder(r=bushing_r, h=bushing_h, $fn=resolution);
		}
	cylinder(r=axel_r, h=20,$fn=resolution);
}


	translate([bushing_r,axel_r,rotor_h])
		cube([blade_l, blade_t, blade_h]);

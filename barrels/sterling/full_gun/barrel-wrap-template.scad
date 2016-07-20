


PVC_d=42.22;
PVC_circumference=PVC_d*PI;
echo (PVC_circumference);

barrel_l=11*25;

vent_d=18-7;
vent_r=vent_d/2;
vent_radial_offset=PVC_circumference/4;

tip_to_vent_offset=27;   // ?

projection(cut = true)
difference(){
	cube([PVC_circumference,barrel_l,1]);
	translate([5,tip_to_vent_offset+vent_r,0])
	union(){
		for (x = [0,1,2,3,4])
			for (y = [0,1,2,3,4,5,6,7,8,9])
				translate([x*vent_radial_offset,y*2*vent_d,-1])
//#					cylinder(r=vent_r, h=10);
#					cylinder(r=1, h=10);
		for (x = [0,1,2,3])
			for (y = [0,1,2,3,4,5,6,7,8])
				translate([x*vent_radial_offset+vent_radial_offset/2,y*2*vent_d+vent_d,-1])
//#					cylinder(r=vent_r, h=10);
#					cylinder(r=1, h=10);
	}
}

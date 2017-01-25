gear_dxf_source="gg_gear.dxf";

sight_thickness=7;
sight_line_thickness=4;

//rail;



total_width = dxf_dim(file = gear_dxf_source, name = "total_width"); 
total_height = dxf_dim(file = gear_dxf_source, name = "total_height"); 
echo (total_width, total_height);

translate([0,-total_height,0])
	linear_extrude(height =7 , center = true, convexity = 10)
		import(file=gear_dxf_source, convexity=3);
		
	difference(){
		union(){	
			translate([0,0,-sight_thickness/2])
				cylinder(r=10, h=10);
			cube([sight_line_thickness,	total_width-40,7],center=true);
			cube([total_width-40 , sight_line_thickness, sight_thickness], center=true);
		}
		translate([0,0,-sight_thickness/2-0.5])
			cylinder(r=8, h=11);
	}
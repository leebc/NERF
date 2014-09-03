rotate_extrude()
	rotate([0,180,-90])
		hull()
		{
		square ([3,(38.1-3)/2]);
		translate([0,(38.1-3)/2,0])
			difference()
			{
				circle(r=3, center=false);
				translate([-3,-3])		
					square([3,6]);
			}
		}


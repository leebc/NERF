extrusion_height=85;
bound_height=28;
scale_up=1.333333333333333;
y_spacer=39.8/3/2;
y_offset=4;

difference(){

scale(v=[scale_up,scale_up,scale_up])
	intersection(){
		union(){				// The ends
			translate([extrusion_height,0,0.6])			rotate([0,-90,0])
				color("red")
					linear_extrude(height = extrusion_height)
						import ("/home/blee/Pictures/communicator/template-trace3-end-top.dxf");

			translate([extrusion_height,0,-10.2])		rotate([0,-90,0])
				color("orange")
					linear_extrude(height = extrusion_height)
						import ("/home/blee/Pictures/communicator/template-trace3-end-bottom.dxf");
		}

		union(){				// The sides
			translate([0,-1.25,11])	rotate([-90,1,0]) 
				color("darkblue")
					linear_extrude(height = extrusion_height)
						import ("/home/blee/Pictures/communicator/template-trace3-side-top.dxf");
			translate ([0,0,1])		rotate([-90,1.25,0])
				color("blue")
					linear_extrude(height = extrusion_height)
						import ("/home/blee/Pictures/communicator/template-trace3-side-bottom.dxf");
		}
								// The top
		translate([0,0,-1*extrusion_height/2])			rotate([0,0,0])
			color("yellow")
				linear_extrude(height = extrusion_height)
					import ("/home/blee/Pictures/communicator/template-trace3-top.dxf");
	}


union()
{

//The controls cutout
	intersection()
	{
		translate([98.6,72,-3.1])
			scale([0.40,0.40,0.40])
				rotate([-90,0,180])
					linear_extrude(height = extrusion_height*2)
						import ("/home/blee/Pictures/communicator/AEZ-ControlElevations.dxf");

		translate([2*extrusion_height,20,-4.5])
			scale([0.31,0.31,0.31])
				rotate([-90,0,90])
				{
					translate([-50,0,0])  color ("green")
					linear_extrude(height = 10*extrusion_height)
						import ("/home/blee/Pictures/communicator/Alpha-ControlFront.dxf");
	
					translate([126,0,10*extrusion_height])  color ("lightgreen")
						rotate([0,180,0])
						linear_extrude(height = 10*extrusion_height)
							import ("/home/blee/Pictures/communicator/Alpha-ControlFront.dxf");
				}
	}	// End intersection

	// slots for antenna
	union()
	{
		translate([102,13.5,1.5])
			rotate([90,0,0])
				cylinder(h=3, r=10);
		translate([102,53.1,1.5])
			rotate([90,0,0])
				cylinder(h=3, r=10);

		//  Square Hole for display
		translate([54,11.9,-6])
			cube([34.6,39.8,6]);

		//	Round holes for LEDs
		translate([48,11.9+y_spacer,-10])  //y was 20
			rotate([0,-31,0])
				cylinder(h=12,r=2.5, $fn=60);

		translate([48,11.9+3*y_spacer,-10])
			rotate([0,-31,0])
				cylinder(h=12,r=2.5, $fn=60);

		translate([48,11.9+5*y_spacer,-10])
			rotate([0,-31,0])
				cylinder(h=12,r=2.5, $fn=60);


		//  Square Holes for components
		translate([5,y_offset,-7])
			cube([36.6,55.8,7]);

		translate([5,y_offset,-3.5])	//Overlaps into the bottom
			cube([85.6,55.8,10]);

		translate([20,y_offset,-3.5])	//  Just the bottom
			cube([70.6,55.8,15]);
	}

//difference					// Remove the top or //bottom to save for printing
	translate([0,0,-1*bound_height])
		color("green")
			cube([113.5,63.5,bound_height]);
}

}
width=29/78.5;
echo("width ratio:", width);
//267









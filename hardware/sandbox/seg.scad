include <../config/config.scad>

// sketch of a segment


// servo driver board
color("white")
translate([-26/2,40 - 63/2,20])
    cube([26, 63, 26]);

// joint servo
attach([[-8,0,10], [1,0,0], -90,0,0], MicroServo_Con_Fixing1) {
    MicroServo();
    attach(rollConnector(MicroServo_Con_Horn,90), ServoHorn_Con_Def) ServoHorn();
}

// wheel
translate([0, 40, 16/2])
    rotate([0,90,0])
    cylinder(r=16/2, h=4, center=true);


// approx seg volume
translate([0,0,30])
    rotate([-90,25,0])
    tube(or=30, ir = 28, h=80, $fn=8, center=false);

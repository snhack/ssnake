include <../config/config.scad>

// sketch of a segment

module segment() {
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
    color("white")
    translate([0,0,25])
        scale([1,1,0.8])
        rotate([-90,25,0])
        tube(or=30, ir = 28, h=80, $fn=8, center=false);

    // hinge points
    color("white")
        translate([0,-20,15])
        cylinder(r=5, h=20);

    color("white")
        translate([0,100,15])
        cylinder(r=5, h=20);
}

module segment2() {
    // servo driver board
    color("white")
    translate([0, 30 - 63/2, 5])
        cube([15, 63, 26]);

    // joint servo
    attach([[-8,0,24], [0,0,-1], -90,0,0], MicroServo_Con_Fixing1) {
        MicroServo();
        attach(rollConnector(MicroServo_Con_Horn,90), ServoHorn_Con_Def) ServoHorn();

        // push rod
        translate([5,-8,31])
            rotate([0,0,195])
            cube([40,1,1]);
    }

    // wheel
    translate([0, 40, 16/2])
        rotate([0,90,0])
        cylinder(r=16/2, h=16, center=true);


    // approx seg volume
    color("white")
    translate([0,30,23])
        rotate([-90,0,0])
        chamferedCube([50,40,60], 10, center=true, shell=2);

    color("white")
        hull() {
            // mid section
            translate([-25,0,13])
                cube([50,60, 10]);

            // hinge points
            color("white")
                translate([0,-15,13])
                cylinder(r=5, h=10);

            color("white")
                translate([0,75,13])
                cylinder(r=5, h=10);
        }


}

// option 1
//segment();


// option 2
for (i=[0:7])
    translate([0,i*90,0])
    segment2();

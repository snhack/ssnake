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

module segment3() {
    w = 40;
    d = 30;
    hingeOffset = 10;
    wheelOR = 15/2;

    // joint servo
    attach([[2,-4,26], [-1,0,0], -90,0,0], MicroServo_Con_Fixing1) {
        MicroServo();
        attach(rollConnector(MicroServo_Con_Horn,90), ServoHorn_Con_Def) ServoHorn();

        // push rod
        translate([8,-7,28])
            rotate([0,0,180])
            cube([40,1,1]);
    }
    /*
    attach([[-14,5,23], [0,0,-1], 0,0,0], MicroServo_Con_Fixing1) {
        MicroServo();
        attach(rollConnector(MicroServo_Con_Horn,0), ServoHorn_Con_Def) ServoHorn();

        // push rod
        translate([19,4,31])
            rotate([0,0,270])
            cube([40,1,1]);
    }
    */

    // wheel
    translate([0, d/2, wheelOR])
        rotate([0,90,0])
        cylinder(r=wheelOR, h=16, center=true);


    // approx seg volume
    color("white")
    translate([0,d/2,23])
        rotate([-90,0,0])
        chamferedCube([w,40,d], 10, center=true, shell=2);

    color("white")
        hull() {
            // mid section
            translate([-w/2,0,13])
                cube([w,d, 10]);

            // hinge points
            color("white")
                translate([0,-hingeOffset,13])
                cylinder(r=5, h=10);

            color("white")
                translate([0,d + hingeOffset,13])
                cylinder(r=5, h=10);
        }


}

module head3() {
    w = 40;
    d = 50;
    hingeOffset = 10;
    wheelOR = 15/2;

    // servo driver board
    color("white")
    translate([-26/2, 20 - 63/2, wheelOR*2])
        cube([26, 63, 26]);

    // wheel
    translate([0, d/2, wheelOR])
        rotate([0,90,0])
        cylinder(r=wheelOR, h=16, center=true);


    // approx seg volume
    color("white")
    translate([0,d/2,23])
        rotate([-90,0,0])
        chamferedCube([w,40,d], 10, center=true, shell=2);

    color("white")
        hull() {
            // mid section
            translate([-w/2,0,13])
                cube([w,d, 20]);

            // hinge point
            color("white")
                translate([0,d + hingeOffset,13])
                cylinder(r=5, h=10);

            // mouth
            color("white")
                translate([0,-30,13])
                cylinder(r=10, h=10);
        }


}

module tail3() {
    w = 40;
    d = 20;
    hingeOffset = 10;
    wheelOR = 15/2;

    // battery
    color("white")
    translate([-18/2, 30 - 63/2, 6])
        cube([18, 60, 32]);

    // approx seg volume
    color("white")
    translate([0,d/2,23])
        rotate([-90,0,0])
        chamferedCube([w,40,d], 10, center=true, shell=2);

    color("white")
        hull() {
            // mid section
            translate([-w/2,0,13])
                cube([w,d, 20]);

            // hinge point
            color("white")
                translate([0, -hingeOffset,13])
                cylinder(r=5, h=10);

            // tail
            color("white")
                translate([0,d + 40,13])
                cylinder(r=10, h=20);
        }
}

module arrangeSegments(num, ang) {
    if (num > 0) {
        translate([0,10,0])
            segment3();

        translate([0,50,0])
            rotate([0,0,ang])
            arrangeSegments(num-1, 30 * sin(num * 50));
    } else {
        translate([0,10,0])
            tail3();
    }
}

// option 1
//segment();


// option 2
*for (i=[0:7])
    translate([0,i*90,0])
    segment2();

module snake3() {
    // option 3
    // short body segments
    // larger head to accommodate driver board and NodeMCU
    // long-ish tail to accommodate battery - LIPO?
    translate([0,-60,0])
        head3();
    arrangeSegments(13, 30);
}

segment3();

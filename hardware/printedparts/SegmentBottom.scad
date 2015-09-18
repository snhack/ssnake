// Connectors

SegmentBottom_Con_Def = [[0,0,0], [0,0,-1], 0,0,0];

SegmentBottom_Con_Wheel = [[0,0,SegmentWheelOR - SegmentGroundClearance], [1,0,0], 0,0,0];

SegmentBottom_Con_ServoFixing = [[2, -SegmentDepth/2, SegmentHeight/2], [-1,0,0], -90,0,0];

SegmentBottom_Con_Hinge1 = [[0,-SegmentDepth/2 -SegmentHingeOffset, SegmentHingeHeight], [0,0,-1], 0,0,0];

SegmentBottom_Con_Hinge2 = [[0, SegmentDepth/2 + SegmentHingeOffset, SegmentHingeHeight], [0,0,-1], 0,0,0];

module SegmentBottom_STL() {

    printedPart("printedparts/SegmentBottom.scad", "Segment Bottom", "SegmentBottom_STL()") {

        view(t=[0,0,0],r=[72,0,130],d=400);

        if (DebugCoordinateFrames) frame();
        if (DebugConnectors) {
            connector(SegmentBottom_Con_Def);
            connector(SegmentBottom_Con_Wheel);
            connector(SegmentBottom_Con_ServoFixing);
            connector(SegmentBottom_Con_Hinge1);
            connector(SegmentBottom_Con_Hinge2);
        }

        color(Level2PlasticColor) {
            if (UseSTL) {
                import(str(STLPath, "SegmentBottom.stl"));
            } else {
                SegmentBottom_Model();
            }
        }
    }
}


module SegmentBottom_Model()
{
    // local vars

    // model
    difference() {
        union() {
            // hinge1
            attach(SegmentBottom_Con_Hinge1, DefConDown)
                cylinder(r=SegmentHingeOR, h=SegmentHingeThickness, center=true);

            // hinge 2
            attach(SegmentBottom_Con_Hinge2, DefConDown)
                cylinder(r=SegmentHingeOR + dw, h=SegmentHingeThickness, center=true);

            // hinge joints
            translate([0,0,SegmentHingeHeight])
                cube([tw, SegmentDepth + 2*SegmentHingeOffset, SegmentHingeThickness], center=true);

            hull() {
                // hinge joints
                translate([0,0,SegmentHingeHeight])
                    cube([tw, SegmentDepth + SegmentHingeOffset, SegmentHingeThickness], center=true);

                // body plate
                translate([0,0,SegmentHingeHeight])
                    cube([SegmentWidth, SegmentDepth, SegmentHingeThickness], center=true);
            }

        }

        // weight loss under servo
        translate([-5,-2,SegmentHingeHeight])
            cube([14,14,12], center=true);

        // clearance for servo horn
        translate([14,-7,SegmentHingeHeight])
            cube([8,22,20], center=true);

        // hollow hinge 2
        attach(SegmentBottom_Con_Hinge2, DefConDown)
            cylinder(r=SegmentHingeOR, h=SegmentHingeThickness+2, center=true);

        attach(SegmentBottom_Con_Hinge2, DefConDown)
            rotate([0,0,30])
            sector3D(r=SegmentHingeOR+tw, a=120, h=SegmentHingeThickness+2, center=true);

        // hollow for servo
        attach(SegmentBottom_Con_ServoFixing, MicroServo_Con_Fixing1)
            MicroServo_BodySubVolume();

    }
}


module SegmentAssembly () {

    assembly("assemblies/Segment.scad", "Segment", str("SegmentAssembly()")) {

        // base part
        SegmentBottom_STL();

        // steps
        step(1, "wheel") {
                view();

                attach(SegmentBottom_Con_Wheel, SegmentWheel_Con_Def) {
                    SegmentWheel_STL();

                    // wire axle
                    color("grey")
                        cylinder(r=1/2, h=SegmentWheelWidth + 6, center=true);

                }

        }


        step(2, "servo") {
            view();

            attach(SegmentBottom_Con_ServoFixing, MicroServo_Con_Fixing1) {
                MicroServo();
                attach(rollConnector(MicroServo_Con_Horn,90), ServoHorn_Con_Def) ServoHorn();

                // push rod
                translate([8,-7,28])
                    rotate([0,0,180])
                    cube([40,1,1]);
            }
        }

    }
}

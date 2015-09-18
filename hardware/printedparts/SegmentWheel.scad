// Connectors

SegmentWheel_Con_Def = [[0,0,0], [0,0,-1], 0,0,0];


module SegmentWheel_STL() {

    printedPart("printedparts/SegmentWheel.scad", "Segment Wheel", "SegmentWheel_STL()") {

        view(t=[0,0,0],r=[72,0,130],d=400);

        if (DebugCoordinateFrames) frame();
        if (DebugConnectors) {
            connector(SegmentWheel_Con_Def);
        }

        color(Level3PlasticColor) {
            if (UseSTL) {
                import(str(STLPath, "SegmentWheel.stl"));
            } else {
                SegmentWheel_Model();
            }
        }
    }
}


module SegmentWheel_Model()
{
    // local vars

    // hub
    tube(or=4, ir=1/2, h=SegmentWheelWidth, center=true);

    // rims
    for (i=[0,1])
        mirror([0,0,i])
        conicalTube(or1=4, ir1=1/2, or2=SegmentWheelOR, ir2=1/2, h=SegmentWheelWidth/2);
}

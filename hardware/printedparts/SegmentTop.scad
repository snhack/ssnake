// Connectors

SegmentTop_Con_Def = [[0,0,0], [0,0,-1], 0,0,0];


module SegmentTop_STL() {

    printedPart("printedparts/SegmentTop.scad", "Segment Top", "SegmentTop_STL()") {

        view(t=[0,0,0],r=[72,0,130],d=400);

        if (DebugCoordinateFrames) frame();
        if (DebugConnectors) {
            connector(SegmentTop_Con_Def);
        }

        color(Level3PlasticColor) {
            if (UseSTL) {
                import(str(STLPath, "SegmentTop.stl"));
            } else {
                SegmentTop_Model();
            }
        }
    }
}


module SegmentTop_Model()
{
    // local vars

    // model
    difference() {
        union() {
            cube([10,10,10]);
        }


    }
}

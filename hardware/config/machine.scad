//
// Machine
//

// Coding-style
// ------------
//
// Global variables are written in UpperCamelCase.
// A logical hierarchy should be indicated using underscores, for example:
//     StepperMotor_Connections_Axle
//
// Global short-hand references should be kept to a minimum to avoid name-collisions


// Global Settings for Printed Parts
//

DefaultWall 	= 4*perim;
ThickWall 		= 8*perim;

// short-hand
dw 				= DefaultWall;
tw 				= ThickWall;


// Global design parameters
SegmentWidth = 40;
SegmentDepth = 30;
SegmentHeight = 40;
SegmentGroundClearance = 3;

SegmentHingeOffset = 10;  // offset in Y relative to segment body
SegmentHingeHeight = SegmentHeight/2 - 4;  // height of centreline relative to base of body
SegmentHingeThickness = 8;
SegmentHingeOR = 8/2;

SegmentWheelOR = 14/2;
SegmentWheelWidth = 15;

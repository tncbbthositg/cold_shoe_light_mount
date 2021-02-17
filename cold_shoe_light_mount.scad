/* [Mounting Bracket] */

// thickness of mounting brackets
mountBracketThickness = 2.24;

// should there be a top clamp?
hasTopClamp = true;

// gap between top and bottom mounting brackets
mountGapDistance = 1.5;

/* [Flashlight Params] */
// how much clearance does the light need
clearance = 18;

// diameter of flashlight
flashlightDiameter = 15;

// how much smaller should the ring be than the light
clampTightness = 2;

// how deep is the clamp
clampDepth = 9.5;

// how thick is the clamp
clampThickness = 1.5;

// what angle should the clamp gap be cut at
clampGapAngle = 120; // [10:170]

/* [Print Settings] */

// smoother renders slower
quality = 8; //[2:Draft, 4:Medium, 8:Fine, 16:Ultra Fine]

/* [Hidden] */
// the width of the mounting bracket
mountWidth = 18;

// print quality settings
$fa = 12/quality;
$fs = 2/quality;

// computed values
clampRadius = (flashlightDiameter - clampTightness) / 2;
ringRadius = clampRadius + clampThickness;
totalColumnLength = mountGapDistance + mountBracketThickness + clearance;
ringCenter = totalColumnLength + clampRadius;

difference() {
    // solid part
    union() {
        // coldshoe mount
        cube([mountBracketThickness, mountWidth, mountWidth]);

        // clamp for coldshoe to hold fast
        if (hasTopClamp)
            translate([mountGapDistance + mountBracketThickness, 0, 0])
                cube([mountBracketThickness, mountWidth, mountWidth]);

        // post
        translate([0, (mountWidth - 6) / 2, 0])
            color("green") cube([ringCenter, 6, clampDepth]);
                    
        color("red") hull() {
            // post support
            translate([0, (mountWidth - 10) / 2, 0])
                cube([mountGapDistance + mountBracketThickness * 2 + 3, 10, 13]);

            translate([0, (mountWidth - 6) / 2, 0])
                cube([totalColumnLength - 4.3, 6, clampDepth]);
        };

        // clamp
        translate([ringCenter, mountWidth / 2, 0])
            color("blue") cylinder(h = clampDepth, r = ringRadius);
    }
    
    // hole
    translate([ringCenter, mountWidth / 2, 0])
        cylinder(h = clampDepth, r = clampRadius);    

    // flashlight gap
    translate([ringCenter, mountWidth / 2, 0])
        linear_extrude(height = clampDepth) {
            verticalOffset = tan(clampGapAngle / 2) * ringRadius;
            polygon(points=[[0,0], [ringRadius,verticalOffset], [ringRadius,-verticalOffset]]);
        };
};

// round clamp ends
for (side = [-1, 1]) {
    translate([ringCenter, mountWidth / 2, 0])
        rotate([0, 0, clampGapAngle / 2 * side])
            translate([(ringRadius + clampRadius) / 2, 0, 0])
                color("cyan") cylinder(h = clampDepth, r = clampThickness / 2);
};

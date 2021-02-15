/* [Mounting Bracket] */

// thickness of mounting brackets
mountBracketThickness = 2.24;

// should there be a top clamp
hasTopClamp = true;

// gap between top and bottom brackets
gapDistance = 1.5;

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

/* [Hidden ] */
// the width of the mounting bracket
mountWidth = 18;

// computed values
clampRadius = (flashlightDiameter - clampTightness) / 2;
ringRadius = clampRadius + clampThickness;
totalColumnLength = gapDistance + mountBracketThickness + clearance;
ringCenter = totalColumnLength + clampRadius;

difference() {
    // solid part
    union() {
        // coldshoe mount
        cube([mountBracketThickness, mountWidth, mountWidth]);

        // clamp for coldshoe to hold fast
        if (hasTopClamp)
            translate([gapDistance + mountBracketThickness, 0, 0])
                cube([mountBracketThickness, mountWidth, mountWidth]);

        // post
        translate([0, (mountWidth - 6) / 2, 0])
            color("green") cube([ringCenter, 6, clampDepth]);
                    
        color("red") hull() {
            // post support
            translate([0, (mountWidth - 10) / 2, 0])
                cube([gapDistance + mountBracketThickness * 2 + 3, 10, 13]);

            translate([0, (mountWidth - 6) / 2, 0])
                cube([totalColumnLength - 4.3, 6, clampDepth]);
        };

        // clamp
        translate([ringCenter, mountWidth / 2, 0])
            color("blue") cylinder(h = clampDepth, r = ringRadius, $fn = 60);
    }
    
    // hole
    translate([ringCenter, mountWidth / 2, 0])
        cylinder(h = clampDepth, r = clampRadius, $fn = 60);    

    // flashlight gap
    translate([ringCenter, mountWidth / 2, 0])
        linear_extrude(height = clampDepth) {
            verticalOffset = tan(clampGapAngle / 2) * ringRadius;
            polygon(points=[[0,0], [ringRadius,verticalOffset], [ringRadius,-verticalOffset]]);
        };
};

for (side = [-1, 1]) {
    translate([ringCenter, mountWidth / 2, 0])
        rotate([0, 0, clampGapAngle / 2 * side])
            translate([(ringRadius + clampRadius) / 2, 0, 0])
                color("cyan") cylinder(h = clampDepth, r = clampThickness / 2, $fn = 60);
};
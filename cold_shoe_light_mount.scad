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

/* [Hidden ] */
mountWidth = 18;

clampRadius = (flashlightDiameter - clampTightness) / 2;
ringRadius = clampRadius + clampThickness;
totalColumnLength = gapDistance + mountBracketThickness + clearance;
clampGapWidth = clampRadius * 2 * .625;

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
            cube([totalColumnLength, 6, clampDepth]);
                    
        hull() {
            // post support
            translate([0, (mountWidth - 10) / 2, 0])
                cube([gapDistance + mountBracketThickness * 2 + 3, 10, 13]);

            translate([0, (mountWidth - 6) / 2, 0])
                cube([totalColumnLength - 4.3, 6, clampDepth]);
        };

        // clamp
        translate([totalColumnLength + clampRadius, mountWidth / 2, 0])
            color("blue") cylinder(h = clampDepth, r = ringRadius, $fn=60);
    }
    
    // hole
    translate([totalColumnLength + clampRadius, mountWidth / 2, 0])
        color("green") cylinder(h = clampDepth, r = clampRadius, $fn=60);    

    // flashlight gap
    translate([totalColumnLength + clampRadius, (mountWidth - clampGapWidth) / 2, 0])
        cube([ringRadius, clampGapWidth, clampDepth]);
}

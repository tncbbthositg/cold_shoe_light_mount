// bracket params
mountBracketThickness = 2.24;
mountWidth = 18;
gapDistance = 1.5;

// post params
clearance = 18; // how high from the top of the cold shoe will the base of the light be

// clamp params
flashlightRadius = 13;
clampDepth = 9.5;
clampThickness = 1.5;


ringRadius = flashlightRadius + clampThickness;
totalColumnLength = gapDistance + mountBracketThickness + clearance;
clampGapWidth = flashlightRadius * 2 * .625;

difference() {
    // solid part
    union() {
        // coldshoe mount
        cube([mountBracketThickness, mountWidth, mountWidth]);

        // clamp for coldshoe to hold fast
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
        translate([totalColumnLength + flashlightRadius, mountWidth / 2, 0])
            color("blue") cylinder(h = clampDepth, r = ringRadius, $fn=60);
    }
    
    // hole
    translate([totalColumnLength + flashlightRadius, mountWidth / 2, 0])
        color("green") cylinder(h = clampDepth, r = flashlightRadius, $fn=60);    

    // flashlight gap
    translate([totalColumnLength + flashlightRadius, (mountWidth - clampGapWidth) / 2, 0])
        cube([ringRadius, clampGapWidth, clampDepth]);
}

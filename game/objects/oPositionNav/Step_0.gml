// Step Event for the object

// Calculate distance to oCamera
var cx = 0;
var cy = 0;
with(oCamera) {
	cx = x;
	cy = y;
}

image_angle = (image_angle + rot_spd) % 360;
var distance = point_distance(x, y, cx, cy);

// Define fade boundaries
var start_fade_distance = 220;
var end_fade_distance = 150;

// Calculate transparency
if (distance <= end_fade_distance) {
    image_alpha = 0; // Fully transparent
	image_xscale = 1;
	image_yscale = 1;
	part_type_alpha3(_ptype3, 0, 0, 0);
	part_type_alpha3(_ptype2, 0, 0, 0);
	part_type_alpha3(_ptype1, 0, 0, 0);
	fade_ratio = 0;
} else if (distance >= start_fade_distance) {
    image_alpha = 1; // Fully opaque
	image_xscale = 1;
	image_yscale = 1;
	part_type_alpha3(_ptype3, 0.278, 0.159, 0);
	part_type_alpha3(_ptype2, 0.098, 0.159, 0);
	part_type_alpha3(_ptype1, 0, 0.198, 0);
	fade_ratio = 1;
} else {
    fade_ratio = (distance - end_fade_distance) / (start_fade_distance - end_fade_distance);
    image_alpha = fade_ratio;
	image_xscale = 1 + (1 - fade_ratio);
	image_yscale = 1 + (1 - fade_ratio);
	var fr = fade_ratio;

    // Apply the calculated fade values
	part_type_alpha3(_ptype3, fr*0.278, fr*0.159, fr*0);
	part_type_alpha3(_ptype2, fr*0.098, fr*0.159, fr*0);
	part_type_alpha3(_ptype1, fr*0, fr*0.198, fr*0);
}

fade_ratio = fade_ratio;

part_system_position(_ps, x, y);
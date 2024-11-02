// Step Event for the object

// Calculate distance to oCamera
var cx = 0;
var cy = 0;
with(oCamera) {
	cx = x;
	cy = y;
}

var distance = point_distance(x, y, cx, cy);

// Define fade boundaries
var start_fade_distance = 220;
var end_fade_distance = 150;

// Calculate transparency
if (distance <= end_fade_distance) {
    image_alpha = 0; // Fully transparent
} else if (distance >= start_fade_distance) {
    image_alpha = 1; // Fully opaque
} else {
    var fade_ratio = (distance - end_fade_distance) / (start_fade_distance - end_fade_distance);
    image_alpha = fade_ratio;
}

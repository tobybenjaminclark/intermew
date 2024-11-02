/// @description Plot the graph to the screen.
// You can write your code in this editor

// Draw Axis
draw_line(ox, oy, ox + w, oy);
draw_line(ox, oy, ox, oy - h);

var series_length = array_length(x_values);
var prev_x = ox + x_values[0];
var prev_y = oy - y_values[0];

for (var i = 1; i < series_length; i++) {
	var cx = ox + ((x_values[i]) * (w / i));
	var cy = oy - ((y_values[i]) * (w / i));
	draw_line(prev_x, prev_y, cx, cy);
	prev_x = cx;
	prev_y = cy;
}

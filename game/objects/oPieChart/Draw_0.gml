/// @description Writes the pie chart to the surface using primitives.

// Pie Chart Data and Colors
var data = [30, 70, 20, 50]; // Values for each segment
var colors = [c_red, c_green, c_blue, c_yellow]; // Colors for each segment

// Define center and radius of the pie chart
var center_x = x;
var center_y = y;
var radius = current_radius;

// Calculate the total of all data points
var total = 0;
for (var i = 0; i < array_length(data); i++) {
    total += data[i];
}

// Initialize the starting angle (in radians)
var start_angle = 0;

// Draw each slice of the pie chart
for (var i = 0; i < array_length(data); i++) {
    // Calculate the fraction of the circle for the current segment
    var segment_angle = (data[i] / total) * (2 * pi);
    
    // Set color for the current segment
    draw_set_color(colors[i]);
    
    // Draw the segment as a series of triangles
    var steps = 50; // Increase steps for a smoother segment
    var angle_step = segment_angle / steps;
    
    for (var j = 0; j < steps; j++) {
        // Calculate the two outer points of the triangle
        var angle1 = start_angle + j * angle_step;
        var angle2 = start_angle + (j + 1) * angle_step;
        
        var x1 = center_x + lengthdir_x(radius, radtodeg(angle1));
        var y1 = center_y + lengthdir_y(radius, radtodeg(angle1));
        var x2 = center_x + lengthdir_x(radius, radtodeg(angle2));
        var y2 = center_y + lengthdir_y(radius, radtodeg(angle2));
        
        // Draw triangle for this part of the segment
        draw_triangle(center_x, center_y, x1, y1, x2, y2, false);
    }
    
    // Update start_angle for the next segment
    start_angle += segment_angle;
}

// Reset the draw color to white (or another default color)
draw_set_color(c_white);

// Draw Text Label
draw_set_halign(fa_center);
draw_set_alpha(current_step / PIE_CHART_TIME)
draw_set_font(PIE_CHART_LABEL_FONT);
draw_text(x, y + upper_radius + PIE_CHART_LABEL_OFFSET, label)
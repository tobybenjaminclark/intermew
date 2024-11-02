
function draw_outlined_text(x, y,text) {
    // Set the color for the outline
	
	outline_color = c_black;
	text_color = c_white;
	outline_thickness = 5;
    draw_set_color(outline_color);

    // Draw the text at offset positions for the outline effect
    for (var dx = -outline_thickness; dx <= outline_thickness; dx++) {
        for (var dy = -outline_thickness; dy <= outline_thickness; dy++) {
            // Skip the center to avoid drawing the original text multiple times
            if (dx != 0 || dy != 0) {
                draw_text(x + dx, y + dy, text);
            }
        }
    }

    // Set the color for the main text
    draw_set_color(text_color);
    draw_text(x, y, text);
}
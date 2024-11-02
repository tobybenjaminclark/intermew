/// @description Draws to screen.

draw_set_halign(fa_left);

draw_text(10, 10, "Mode: " + mode);  // Display current mode

// Draw each line of text
var y_offset = 30;
for (var i = 0; i < array_length(lines); i++) {
    draw_text(10, y_offset + i * 20, lines[i]);
}

// Draw cursor
if (mode == "NORMAL" || mode == "INSERT") {
    var line = lines[cursor_y];
    var cursor_pos_x = 10 + string_width(string_copy(line, 1, cursor_x));
    var cursor_pos_y = y_offset + cursor_y * 20;
    draw_text(cursor_pos_x, cursor_pos_y, "|");
}

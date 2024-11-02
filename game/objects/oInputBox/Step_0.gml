/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(vk_escape)) {
    mode = "NORMAL";  // Switch to NORMAL mode on Escape
}

switch (mode) {
    case "NORMAL":
        handle_normal_mode();
        break;
    case "INSERT":
        handle_insert_mode();
        break;
}

if (keyboard_check_pressed(ord("W"))) {
    // Move to the start of the next word
    var line = lines[cursor_y];
    while (cursor_x < string_length(line) && !string_char_at(line, cursor_x) == " ") {
        cursor_x++;
    }
    while (cursor_x < string_length(line) && string_char_at(line, cursor_x) == " ") {
        cursor_x++;
    }
}

if (keyboard_check_pressed(ord("X"))) {
    // Delete character at cursor
    lines[cursor_y] = string_delete(lines[cursor_y], cursor_x, 1);
}

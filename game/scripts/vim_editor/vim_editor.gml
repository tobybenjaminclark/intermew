// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Normal mode function
function handle_normal_mode() {
    if (keyboard_check_pressed(ord("I"))) {
        mode = "INSERT";  // Switch to Insert mode
    }
    
    if (keyboard_check_pressed(vk_up)) cursor_y = max(0, cursor_y - 1);
    if (keyboard_check_pressed(vk_down)) cursor_y = min(array_length(lines) - 1, cursor_y + 1);
    if (keyboard_check_pressed(vk_left)) cursor_x = max(0, cursor_x - 1);
    if (keyboard_check_pressed(vk_right)) cursor_x = min(string_length(lines[cursor_y]), cursor_x + 1);

    if (keyboard_check_pressed(ord("D"))) {
        // Simple implementation for `dd` command to delete a line
        if (keyboard_check_pressed(ord("D"))) {
            array_delete(lines, cursor_y, 1);
            cursor_y = max(0, cursor_y - 1);
        }
    }
}

// Insert mode function
function handle_insert_mode() {
    if (keyboard_check_pressed(vk_enter)) {
        // Create new line
        array_insert(lines, cursor_y + 1, "");  // Add a new empty line
        cursor_y++;  // Move the cursor down to the new line
        cursor_x = 0;  // Reset cursor position to the start of the new line
    } else if (keyboard_check_pressed(vk_backspace)) {
        // Handle backspace
        if (cursor_x > 0) {
            lines[cursor_y] = string_delete(lines[cursor_y], cursor_x, 1);  // Delete character before cursor
            cursor_x--;  // Move cursor back
        } else if (cursor_y > 0) {
            // Merge with previous line if at the start of the line
            cursor_x = string_length(lines[cursor_y - 1]);  // Move cursor to the end of the previous line
            lines[cursor_y - 1] += lines[cursor_y];  // Merge current line with previous
            array_delete(lines, cursor_y, 1);  // Delete current line
            cursor_y--;  // Move cursor up to the merged line
        }
    } else {
        // Handle other key inputs (for character insertion)
        for (var key = 32; key <= 126; key++) {  // ASCII range for printable characters
            if (keyboard_check_pressed(key)) {
                var character = chr(key);  // Get the character from the key code
                lines[cursor_y] = string_insert(lines[cursor_y], character, cursor_x + 1); 
                cursor_x++;  // Move cursor to the right
            }
        }
    }
}

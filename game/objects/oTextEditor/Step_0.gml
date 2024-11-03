//show_debug_message("Key " + string(keyboard_lastkey));

if (keyboard_check_pressed(vk_enter)) {
    notepad_text += "\n"; // Add a new line
} 
else if (keyboard_check_pressed(vk_backspace)) {
    if (string_length(notepad_text) > 0) {
        notepad_text = string_delete(notepad_text, string_length(notepad_text), 1);
    }
} 
else if (keyboard_check_pressed(vk_space)) {
    notepad_text += " "; // Add a space
} 
else if (keyboard_check_pressed(vk_tab)) {
    notepad_text += "   "; // Add spaces for a tab
} 
else if (keyboard_check_pressed(187)) {
    notepad_text += "="; // Add equal sign
} 
else if (keyboard_check_pressed(186)) {
    notepad_text += ":"; // Add colon
} 
else {
    // Loop through key codes for printable characters
    for (var key = 32; key <= 189; key++) { // Limit to printable ASCII
        if (keyboard_check_pressed(key)) {
            var char_to_add;

            // Handle shift key combos for special characters
            if (keyboard_check(vk_shift)) {
                switch (key) {
                    case ord("1"): char_to_add = "!"; break;
                    case ord("2"): char_to_add = "\""; break;
                    case ord("3"): char_to_add = "£"; break; 
                    case ord("4"): char_to_add = "$"; break;
                    case ord("5"): char_to_add = "%"; break;
                    case ord("6"): char_to_add = "^"; break;
                    case ord("7"): char_to_add = "&"; break;
                    case ord("8"): char_to_add = "*"; break;
                    case ord("9"): char_to_add = "("; break;
                    case ord("0"): char_to_add = ")"; break;
                    case ord("="): char_to_add = "+"; break;
                    case ord(";"): char_to_add = ":"; break;
                    case ord("'"): char_to_add = "@"; break;
                    case ord("#"): char_to_add = "~"; break; 
                    case ord("["): char_to_add = "{"; break;
                    case ord("]"): char_to_add = "}"; break;
                    case ord("\\"): char_to_add = "|"; break;
                    case ord(","): char_to_add = "<"; break;
                    case ord("."): char_to_add = ">"; break;
                    case ord("/"): char_to_add = "?"; break;
                    case 189: char_to_add = "_"; break;
                    default: char_to_add = chr(key); break;
                }
            } else {
                // No shift key, add the regular character
                char_to_add = chr(key);
            }

            // Convert the character to lowercase before adding
			if key != 16 {notepad_text += string_lower(char_to_add); }

            // Debug output for added character
            show_debug_message("Added character: " + char_to_add);
            break; // Exit the loop once a key is added
        }
    }
}

// Print the accumulated text
show_debug_message(notepad_text);
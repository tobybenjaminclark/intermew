function draw_wrapped_text(_x, _y, text, max_characters) {
    var line_start = 1;
    var line_y = _y;
    
    // Loop to create and draw each line
    while (line_start <= string_length(text)) {
        // Get a substring up to the max character limit or the remaining text
        var line_text = string_copy(text, line_start, max_characters);
        
        // Find the last space within the line to avoid splitting words
        var split_pos = string_length(line_text);
        if (line_start + max_characters < string_length(text)) {
            while (split_pos > 1 && string_char_at(line_text, split_pos) != " ") {
                split_pos--;
            }
            line_text = string_copy(line_text, 1, split_pos);
        }
        
        // Draw the line
        draw_text(_x, line_y, line_text);
        
        // Move starting point to next part of the text and increase y-position
        line_start += split_pos;
        line_y += string_height(line_text); // Adjust spacing as needed
    }
}
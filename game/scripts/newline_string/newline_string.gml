// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function newline_string(body)
{

	show_index = 0;
	var text_index = 0;

	// Maximum line length
	var max_line_length = 80;

	// Length of the body text
	var body_length = string_length(body);

	// Iterate through the text
	while (text_index < body_length) {
	    // Calculate the end index for the current segment
	    var end_index = min(text_index + max_line_length, body_length);

	    // Find the nearest space within the current line segment
	    var space_index = -1;
	    for (var i = end_index; i > text_index; i--) {
	        if (string_char_at(body, i) == " ") {
	            space_index = i;
	            break;
	        }
	    }

	    // Ensure we do not insert a newline if it results in very short segments
	    if (space_index != -1 && (space_index != body_length - 1)) {
	        body = string_insert("\n", body, space_index);
	        body = string_delete(body, space_index + 1, 1); // Remove the space character
	        text_index = space_index + 1; // Move index to after the newline
	    } else if (end_index < body_length) {
	        // If no suitable space is found, and it's not the end of the string, insert a newline at the max line length
	        body = string_insert("\n", body, end_index);
	        text_index = end_index + 1; // Move index to after the newline
	    } else {
	        text_index = body_length; // Move index to the end of the text
	    }

	    // Update the body length
	    body_length = string_length(body);
	}

	var _bi = string_length(body);
	var _in_loop = true;
	while (_bi > 0 && _in_loop){
		_bi--;
		if string_char_at(body, _bi) == "\n" {
			body = string_insert(" ", body, _bi);
			body = string_delete(body, _bi + 1, 1);
			_in_loop = false;
		}
	}
	return body;


}
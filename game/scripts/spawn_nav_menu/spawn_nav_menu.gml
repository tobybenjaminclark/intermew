// Function to generate interviews from a JSON file
function spawn_nav_menu(file_path) {
	
    // Open the file for reading
    var file = file_text_open_read(file_path);

    // Read the entire file content
    var json_string = "";
    while (!file_text_eof(file)) {
        json_string += file_text_readln(file);
    }
    
    // Close the file after reading
    file_text_close(file);
    
    // Parse the JSON string
    var json_data = json_parse(json_string);

    // Ensure the JSON is valid
    if (is_undefined(json_data)) {
        show_debug_message("Error: Unable to parse JSON.");
        return;
    }
    
    // Parse the data
    var heading = json_data.name;
    var position = json_data.position;
    var interviews = json_data.interviews;

	// Destroy all position navs.
	with(oPositionNav) {
		instance_destroy(self);	
	}
	with(oPieChart) {
		instance_destroy(self);	
	}
	with(oLLMFeedback) {
		instance_destroy(self);	
	}
	with(oGotoSettings) {
		instance_destroy(self);	
	}
	with(oBackToMenu) {
		instance_destroy(self);	
	}
	
	
    // Output or use the parsed data
    show_debug_message("Name: " + heading);
    show_debug_message("Position: " + position);
	
	instance_create_layer(room_width div 2, room_height div 5, "Foreground", oJobHeader, {
		company: heading,
		role: position
	});
	
	// Make return to menu button
	instance_create_layer(50, 50, "Instances", oBackToMenu);
    
	var PADDING_PERCENT = 0.2; // 10% padding from each side
	var num_interviews = array_length(interviews);
	var room_padding = room_width * PADDING_PERCENT;
	var available_width = room_width - (2 * room_padding);
	var spacing = available_width / (num_interviews - 1);
	var all_passed = true;
	for (var i = 0; i < num_interviews; i++) {
	    var _y = (room_height div 8) * 4.5;
	    var _x = room_padding + (spacing * i);
	    var interview = interviews[i];
		if(interview.score < 70){
			all_passed = false;
		}
		
	    instance_create_layer(_x, _y, "Instances", oInterviewNav, {
	        name: interview.name,
	        type: interview.type,
			interview_path: file_path,
			interview_index: i,
			scre: interview.score
	    });
	}
	
	if(all_passed){
		instance_create_layer(room_width div 2,
		room_height - 50,
		"Foreground",
		oURL, {_url:json_data.url});
	}
	
	with(oStatVis) {
		instance_destroy(self);	
	}
	
	return;
}

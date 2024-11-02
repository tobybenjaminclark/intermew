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
    var name = json_data.name;
    var position = json_data.position;
    var interviews = json_data.interviews;

	// Destroy all position navs.
	with(oPositionNav) {
		instance_destroy(self);	
	}
	
    // Output or use the parsed data
    show_debug_message("Name: " + name);
    show_debug_message("Position: " + position);
    
	var OFFSET = 100;
	var WIDTH = 200;
    for (var i = 0; i < array_length(interviews); i++) {
		var _y = room_height div 2;
		var _x = OFFSET + (WIDTH * i);
        var interview = interviews[i];
        instance_create_layer(_x, _y, "Instances", oInterviewNav, {
			name: interview.name,
			type: interview.type
		});
    }
	

	
	
	return;
}

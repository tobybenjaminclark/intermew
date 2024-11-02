// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function start_interview(interview_path, interview_index)
{
    // Open the file for reading
	var file_path = interview_path;
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

	var _x = room_width div 2;
	var _y = room_height div 2;
	var interview = interviews[interview_index];
	instance_create_layer(_x, _y, "Instances", oInterview, {
	    name: interview.name,
	    type: interview.type,
		company: heading,
		role: position,
		interview_path: file_path,
		interview_index: interview_index
	});
	
	// Destroy all position navs.
	with(oPreInterview) {
		instance_destroy(self);	
	}
}
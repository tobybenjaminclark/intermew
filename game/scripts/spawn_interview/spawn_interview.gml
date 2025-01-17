// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function spawn_interview(interview_path, interview_index)
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

	// Destroy all position navs.
	with(oPositionNav) {
		instance_destroy(self);	
	}
	with(oJobHeader) {
		instance_destroy(self);	
	}
	with(oBackToMenu) {
		instance_destroy(self);	
	}

	var _x = room_width div 2;
	var _y = (room_height div 3) * 2;
	var interview = interviews[interview_index];
	instance_create_layer(_x, _y, "Instances", oPreInterview, {
	    name: interview.name,
	    type: interview.type,
		description: json_data.description,
		company: heading,
		role: position,
		interview_path: file_path,
		interview_index: interview_index
	});
	
	with(oInterviewNav) {
		part_particles_clear(_ps)
		part_type_destroy(_ptype1)
		part_emitter_clear(_ps, _pemit1)
		
		part_particles_clear(_ps1)
		part_type_destroy(_ptype2)
		part_emitter_clear(_ps1, _pemit2)
		
		instance_destroy(id);	
	}
	with(oURL) {
		instance_destroy(self);	
	}
	with(oGoToTech) {
		instance_destroy(self);	
	}
}
BUFFER = 200;
cx = room_width div 2;
cy = room_height div 2;
max_radius = 400;

// Get a list of all .json files in the datafiles directory
var file_list = file_find_first("*.json", fa_readonly);
var index = 0;
var num_files = 0;

// First, count the total number of .json files
while (file_list != "")
{
    num_files += 1;
    file_list = file_find_next();
}
file_find_close();

// Reset file list for actual processing
file_list = file_find_first("*.json", fa_readonly);

// Iterate over each found file
while (file_list != "")
{
    index += 1;
	max_radius += 40;
    // Construct the full path for the file
    var file_path = "" + file_list;
        
    // Open the file for reading and check if it was successful
    var file = file_text_open_read(file_path);
    if (file == -1) {
        show_debug_message("Error: Could not open file for reading: " + file_path);
    } else {
        // Read the entire file content
        var json_string = "";
        while (!file_text_eof(file)) {
            json_string += file_text_readln(file) + "\n"; // Add newline for multi-line JSON
        }
            
        // Close the file after reading
        file_text_close(file);
            
        // Parse the JSON string
        var json_data = json_parse(json_string);
        var role = json_data.position;
        var company = json_data.name;
		
		if(company == "Marshall Wace"){
			index -= 1;
		} else {
            
        // Now, let's create an object.
        var angle = (index / num_files) * (6 * 360);
        var _x = cx + lengthdir_x(max_radius, angle);
        var _y = cy + lengthdir_y(max_radius, angle);
        instance_create_layer(_x, _y, "Instances", oPositionNav, {interview_path: file_path,
			_role: role,
			_company: company});
		}
	}
        
    // Move to the next .json file
    file_list = file_find_next();
}
    
// Clean up after the file search
file_find_close();

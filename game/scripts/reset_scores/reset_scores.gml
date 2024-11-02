function reset_scores()
{
    // Get a list of all .json files in the datafiles directory
    var file_list = file_find_first("*.json", fa_readonly);
    
    // Iterate over each found file
    while (file_list != "")
    {
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
            
            // Ensure the JSON is valid
            if (!is_undefined(json_data) && is_array(json_data.interviews)) {
                // Iterate over each interview and set the score to 0
                for (var i = 0; i < array_length(json_data.interviews); i++) {
                    json_data.interviews[i].score = 0;
                }
                
                // Convert the updated JSON data back to a string
                var updated_json_string = json_stringify(json_data);
                
                // Open the file for writing (overwrite mode)
                var write_file = file_text_open_write(file_path);
                if (write_file == -1) {
                    show_debug_message("Error: Could not open file for writing: " + file_path);
                } else {
                    // Write the updated JSON string to the file
                    file_text_write_string(write_file, updated_json_string);
                    
                    // Close the file after writing
                    file_text_close(write_file);
                    
                    show_debug_message("Scores reset for: " + file_path);
                }
            } else {
                show_debug_message("Error: Invalid JSON structure in " + file_path);
            }
        }
        
        // Move to the next .json file
        file_list = file_find_next();
    }
    
    // Clean up after the file search
    file_find_close();
}

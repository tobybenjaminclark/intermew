function update_score(interview_path, interview_index, new_score)
{
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

    // Update the score for the specified interview index
    if (interview_index >= 0 && interview_index < array_length(json_data.interviews)) {
        json_data.interviews[interview_index].score = new_score;
    } else {
        show_debug_message("Error: Interview index out of bounds.");
        return;
    }

    // Convert the updated JSON data back to a string
    var updated_json_string = json_stringify(json_data);

    // Open the file for writing (overwrite mode)
    var write_file = file_text_open_write(file_path);

    // Write the updated JSON string to the file
    file_text_write_string(write_file, updated_json_string);

    // Close the file after writing
    file_text_close(write_file);

    show_debug_message("Score updated successfully.");
}

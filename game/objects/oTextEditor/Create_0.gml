global.title = "";
global.question = "";
global.examples = "";


if (!variable_instance_exists(id, "notepad_text")) {
    notepad_text = "";
}


instance_create_layer(room_width div 2, room_height - 100, oBackToMenu, {});

var filepath = "leetcode/leetcode.json";

var file = file_text_open_read(filepath);


// Read the entire file content
var json_string = "";
while (!file_text_eof(file)) {
    json_string += file_text_readln(file);
}

// Close the file after reading
file_text_close(file);


// Step 2: Parse the JSON string
var json_data = json_parse(json_string);

// Step 3: Check if json_data is an array and iterate over it
if (is_array(json_data)) {
		var l = array_length(json_data)
		var index = random_range(1,l)
	    var entry = json_data[index];

	    // Now entry is a dictionary (object), you can access its fields like this:
	    if variable_struct_exists(entry, "title") {
			global.title = entry.title;
		}
		if variable_struct_exists(entry, "question") {
			global.question = entry.question;
		}
		if variable_struct_exists(entry, "examples") {
			global.examples = entry.examples;
		}
}

instance_create_layer(room_width - 80, room_height - 80, "Instances", oRunVIM, {});
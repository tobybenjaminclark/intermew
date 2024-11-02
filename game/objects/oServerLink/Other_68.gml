
var n_id = ds_map_find_value(async_load, "id");
if(n_id == server_socket)
{
    var t = ds_map_find_value(async_load, "type");
    var socketlist = ds_list_create();

    if(t == network_type_connect)
    {
        var sock = ds_map_find_value(async_load, "socket");
        ds_list_add(socketlist, sock);
    }

    if(t == network_type_data)
    {
        var t_buffer = ds_map_find_value(async_load, "buffer"); 
        var cmd_type = buffer_read(t_buffer, buffer_string);

        // Original string
        originalString = string(cmd_type);

		try
		{
        jsonData = json_parse(originalString)

		// Asynchronous Networking Event
		if variable_struct_exists(jsonData, "from") {
			
			if jsonData.from == "test_stream" {
				show_debug_message(string(jsonData))
			}
		    if jsonData.from == "camera_stream" {
		        show_debug_message("Received from camera thread");
				
				if variable_struct_exists(jsonData, "image_data") and variable_struct_exists(jsonData, "format") {
					show_debug_message("reached here")
					
					var base64_data = jsonData.image_data;
					var format = jsonData.format;

			        // Decode Base64 string to binary
			        var decoded_buffer = buffer_base64_decode(base64_data);

			        // Save as a temporary image file
			        var temp_file = working_directory + "temp_image." + format;
			        buffer_save(decoded_buffer, temp_file);

			        // Load image as sprite
			        global.received_sprite = sprite_add(temp_file, 0, 0, 0, 0, 0);

			        if (global.received_sprite == -1) {
			            show_debug_message("Failed to load sprite");
			        } else {
			            show_debug_message("Sprite loaded successfully");
			        }

			        // Clean up
			        buffer_delete(decoded_buffer);
			        json_destroy(jsonData);
				}


		    }
		}



		}
		catch(e)
		{
		}
		



        //show_debug_message(jsonData)

    }
}
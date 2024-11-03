
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
			
		    if jsonData.from == "camera_stream" {
				
				if variable_struct_exists(jsonData, "image_data") and variable_struct_exists(jsonData, "format") {
					
					var base64_data = jsonData.image_data;
					var format = jsonData.format;

			        // Decode Base64 string to binary
			        var decoded_buffer = buffer_base64_decode(base64_data);

			        // Save as a temporary image file
			        var temp_file = working_directory + "temp_image." + format;
			        buffer_save(decoded_buffer, temp_file);

			        // Load image as sprite
			        global.received_sprite = sprite_add(temp_file, 0, 0, 0, 0, 0);

			        // Clean up
			        buffer_delete(decoded_buffer);
			        json_destroy(jsonData);
				}


		    }
			}
			if jsonData.from == "emotion_stream" {
				if variable_struct_exists(jsonData, "dominant_emotion") {
					var msg = jsonData.dominant_emotion;
					show_debug_message("dominant emotion: " + string(msg));
					
				}
			}
			if jsonData.from == "speech_recognition_stream" {
				
				if variable_struct_exists(jsonData, "message_data") {
					var msg = jsonData.message_data;
					global.user_message = newline_string(msg);
					show_debug_message("user has said: " + string(msg))
					
				}
				
				if variable_struct_exists(jsonData, "action") {
					if jsonData.action == "done" {
						global.who_is_speaking = "user is speaking";
						with(oInterviewVisualiser){
							instance_destroy(self);
						}
						instance_create_layer(room_width div 3, room_height div 3, "Foreground", oVoiceController, {});
					}
				}
				
			}
			if jsonData.from == "interviewer" {
				if variable_struct_exists(jsonData, "message_data") {
					var msg = jsonData.message_data;
					show_debug_message("interviewer has said: '" + string(msg) +"'");
					
					if(msg == "Thank You!"){
						instance_create_layer(x, y, "Instances", oInterviewEnd, {});
					}
					
					global.interviewer_text = newline_string(msg);
					instance_create_layer(x, y, "Foreground", oInterviewVisualiser, {});
					

				}
			}
			if jsonData.from == "end_interviewer" {
				if variable_struct_exists(jsonData, "message_data") {
					var msg = jsonData.message_data;
					show_debug_message("end_interviewer has said: '" + string(msg) +"'");
					instance_create_layer(x, y, "Instances", oInterviewEnd, {});
					global.interviewer_text = newline_string(msg);
					instance_create_layer(x, y, "Foreground", oInterviewVisualiser, {});
					

				}	
			}
			



		}
		catch(e)
		{
		}
		



        //show_debug_message(jsonData)

    }
}
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function server_start_listening(){
	with(oServerLink){
		global.who_is_speaking = "user is speaking"
		// start speech recognition
		new_thread_msg = {from: "speech_recognition_stream", status:"create"};
		send_to_server(new_thread_msg);
	}
	global.user_message = "";
	instance_create_layer(x, y, "Foreground", oSpeechVisualiser, {});
}
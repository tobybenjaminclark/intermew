// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function server_stop_listening(){
	with(oServerLink){
		global.who_is_speaking = "interviewer is speaking"
		new_thread_msg = {action:"input", message_data: global.user_message};
		send_to_server(new_thread_msg);
	}
	with(oSpeechVisualiser){
		instance_destroy(self);
	}
}
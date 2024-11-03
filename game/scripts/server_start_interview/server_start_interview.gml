// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function server_start_interview(){
	with(oServerLink){
		// start emotion
		new_thread_msg = {from: "emotion_stream", status:"create"};
		send_to_server(new_thread_msg);

		// start interview
		new_thread_msg = {action: "start_interview", job_chosen: global.interview_path};
		send_to_server(new_thread_msg);
	}
}
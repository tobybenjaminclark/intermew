// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function start_camera_stream(){
	with(oServerLink){
		new_thread_msg = {from: "camera_stream", status:"create"};
		send_to_server(new_thread_msg);
	}
}
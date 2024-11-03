/// @description Insert description here
// You can write your code in this editor

if(!has_started){
	server_start_listening();
	image_index = 0;
	has_started = true;
} else {
	server_stop_listening();
	instance_destroy(self);
}
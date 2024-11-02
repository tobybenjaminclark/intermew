/// @description Insert description here
// You can write your code in this editor

if(!has_started){
	server_start_listening();
	image_blend = c_aqua;
	has_started = true;
} else {
	server_stop_listening();
	instance_destroy(self);
}
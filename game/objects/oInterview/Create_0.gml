/// @description Insert description here
// You can write your code in this editor

bg_spr = sprOfficeBackground1;
instance_create_layer(0, 0, "BGInstances", oBackground, {spr:bg_spr});

start_camera_stream()
with(oServerLink){
	x = room_width div 2;
	y = room_height div 2;
}
server_start_interview();
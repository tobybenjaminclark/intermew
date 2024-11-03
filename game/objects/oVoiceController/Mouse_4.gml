/// @description Insert description here
// You can write your code in this editor

if(!has_started){
	server_start_listening();
	image_index = 0;
	has_started = true;
	
	// Create Event
	countdown_value = 15;
	alarm[0] = room_speed; // Set alarm to 1 second
} 
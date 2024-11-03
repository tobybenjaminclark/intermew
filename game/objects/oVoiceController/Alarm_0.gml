/// @description Insert description here
// You can write your code in this editor

// Alarm[0] Event
countdown_value -= 1;
if (countdown_value >= 0) {
    alarm[0] = room_speed; // Reset alarm to 1 second
} else {
	server_stop_listening();
	instance_destroy(self);
}

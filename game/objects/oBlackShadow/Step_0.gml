/// @description Insert description here
// You can write your code in this editor

alpha = alpha - 0.005;
if(alpha < 0) {
	instance_destroy(self);	
}
/// @description Insert description here
// You can write your code in this editor
if (global.received_sprite != -1) {
	_x = room_width - sprite_get_width(global.received_sprite) * 0.3;
	_y = 0;
    draw_sprite_ext(global.received_sprite, 0, _x, _y, 0.3, 0.3, 0, c_white, 1);
}
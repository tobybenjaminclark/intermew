/// @description Insert description here
// You can write your code in this editor
if (global.received_sprite != -1) {
    draw_sprite_ext(global.received_sprite, 0, x, y, 0.5, 0.5, 0, c_white, 1);
}

draw_text(200, 200, global.interviewer_text)
draw_text(100, 100, global.who_is_speaking)
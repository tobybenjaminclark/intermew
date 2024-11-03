/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(1);
draw_self();

// Draw Event
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_outlined_text(x + 40, y, string(countdown_value) + "s");
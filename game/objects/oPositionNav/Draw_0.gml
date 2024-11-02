/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_set_alpha(1 - fade_ratio);



draw_set_font(fntHeading);
draw_text(x, y - 20, _company);
draw_set_font(-1)
draw_text(x, y + 10, _role);
draw_text(x, y + 30, "Click to Practice");

draw_set_alpha(1);
/// @description Insert description here
// You can write your code in this editor


draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_font(fntJobHeading);
draw_text(20, (room_height div 2) - 150, "General Feedback");

draw_set_font(-1);
draw_text(20, room_height div 2 - 50, description);


draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_set_font(fntJobHeading);
//draw_text(room_width - 20, (room_height div 2) - 50, "Improvements");

draw_set_font(-1);
//draw_text(room_width - 20, room_height, bddescription);

draw_set_valign(fa_middle);
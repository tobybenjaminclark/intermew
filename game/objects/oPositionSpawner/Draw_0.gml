/// @description Insert description here
// You can write your code in this editor

var _x = room_width div 2;
var _y = room_height div 2;

draw_set_halign(fa_center);
draw_set_font(fntJobHeading);
draw_outlined_text(_x, _y - 20, "Explore The Job Market");

draw_set_font(fntJobSubheading);
draw_text(_x, _y + 30, "Click Opportunities to Take Them");
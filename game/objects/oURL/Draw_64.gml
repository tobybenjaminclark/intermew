/// @description Insert description here
// You can write your code in this editor

/// @description Insert description here
// You can write your code in this editor
// Function to draw outlined text


draw_set_font(fntJobSubheading);
draw_outlined_text(room_width div 2, room_height - 100, "Congratulations! Here is the application URL!");

draw_set_font(fntJobHeading);
draw_outlined_text(room_width div 2, room_height - 75, _url);

draw_set_font(-1);
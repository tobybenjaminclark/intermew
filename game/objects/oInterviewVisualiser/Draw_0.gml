/// @description Insert description here
// You can write your code in this editor

BUFFER = 15;
draw_set_color(c_white);
draw_rectangle(BUFFER, (room_height div 3) * 2, room_width - BUFFER, room_height - BUFFER, true);
draw_rectangle(BUFFER + 1, (room_height div 3) * 2 + 1, room_width - BUFFER - 1, room_height - BUFFER - 1, true);
draw_rectangle(BUFFER + 2, (room_height div 3) * 2 + 2, room_width - BUFFER - 2, room_height - BUFFER - 2, true);

draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(BUFFER + 3, (room_height div 3) * 2 + 3, room_width - BUFFER - 3, room_height - BUFFER - 3, false);

draw_set_alpha(1);
draw_set_color(c_white);

draw_set_font(fntJobSubheading);
draw_text(room_width div 2, (room_height div 5) * 4, global.interviewer_text);

draw_set_font(fntJobHeading);
draw_text(room_width div 5, (room_height div 3) * 2 + 15, "Interviewer");

draw_sprite(sprInterviewIsSpeaking, 0, room_width - BUFFER - 10, room_height - BUFFER - 10);
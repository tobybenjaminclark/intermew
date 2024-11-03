/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(1);

draw_self();
draw_sprite_ext(sprInterviewNode,
0, x, y,
image_xscale * 2.2, image_yscale * 2.2, image_angle, c_white, image_alpha / 2);

draw_sprite_ext(sprInterviewNode,
0, x, y,
image_xscale * 4, image_yscale * 4, image_angle, c_white, image_alpha / 3);


draw_set_halign(fa_center);
draw_set_font(fntGigaHeader);
draw_outlined_text(x, y + 100, "Pre-Interview");

draw_set_font(fntJobHeading);
draw_outlined_text(x, y + 200, "Click Star to Start!");


// draw_text(x, 100, name);

// draw_text(x, y + 140, type);

draw_set_font(fntGigaHeader)
draw_outlined_text(x, 100, company);

draw_set_font(fntJobHeading);
draw_outlined_text(x, 180, role);

draw_set_font(fntJobSubheading);
draw_text(x, 200, newline_string(description));

// Draw some debug stuff.
draw_text(5, room_height - 10, interview_index);
draw_text(100, room_height - 10, interview_path);
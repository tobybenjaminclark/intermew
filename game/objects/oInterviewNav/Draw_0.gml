/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(1);


draw_self();
draw_set_halign(fa_center);

draw_set_font(fntJobSubheading);
draw_text(x, y + 100, "Interview " + string(interview_index + 1));

draw_set_font(fntJobHeading);
draw_text(x, y - 130, name);

draw_set_font(fntJobSubheading);
draw_text(x, y + 140, type);
draw_text(x, y + 160, scre);
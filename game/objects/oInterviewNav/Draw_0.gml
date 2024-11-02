/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(1);


draw_self();
draw_set_halign(fa_center);

draw_set_font(fntJobSubheading);
draw_text(x, y - 200, "Interview " + string(interview_index + 1));

draw_set_font(fntJobHeading);
draw_outlined_text(x, y - 130, name);

draw_set_font(fntJobHeading);
draw_text(x, y + 0, type);

draw_set_font(fntJobSubheading);
draw_text(x, y + 100, "Score");

draw_set_font(fntJobHeading);
draw_outlined_text(x, y + 130, string(scre) + "%");

draw_set_font(fntHeading);
if(scre > 70) {
	draw_text(x, y + 180, "PASSED");
} else {
	draw_text(x, y + 180, "INCOMPLETE");	
}
draw_set_font(-1);
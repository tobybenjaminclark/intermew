/// @description Insert description here
// You can write your code in this editor

/// @description Insert description here
// You can write your code in this editor
// Function to draw outlined text


draw_set_halign(fa_center);
draw_set_font(fntGigaHeader);
draw_outlined_text(x, y - 70, company);

draw_set_halign(fa_center);
draw_set_font(fntJobSubheading);
draw_outlined_text(x, y + 20, role);

draw_set_font(-1);
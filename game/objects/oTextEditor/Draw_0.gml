
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_rectangle(50, 50, 700, 700, false);

draw_set_font(fntJobHeading);
draw_outlined_text(70, 30, "Text Editor (VIM?)")

draw_set_font(fntJobSubheading);
draw_set_color(c_lime);
var lines = string_split(notepad_text, "\n");
var _y = 60;
for (var i = 0; i < array_length(lines); i++) {
    draw_text(60, _y, lines[i]);
    _y += 20; // Move to the next line
}

// Set color and use draw_wrapped_text for each text section
draw_set_color(c_white);
draw_set_font(fntJobHeading);
draw_outlined_text(350, 700, global.pass);
draw_wrapped_text(450, 10, global.title, 80);

draw_set_font(fntJobSubheading);
draw_wrapped_text(450, 200, global.question, 80);
// draw_wrapped_text(450, 600, global.examples, 80);
draw_set_halign(fa_center);
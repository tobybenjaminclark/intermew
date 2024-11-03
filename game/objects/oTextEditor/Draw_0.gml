draw_set_halign(fa_center);
draw_set_color(c_white);
draw_rectangle(50, 50, 400, 700, false);


draw_set_color(c_black);
var lines = string_split(notepad_text, "\n");
var _y = 60;
for (var i = 0; i < array_length(lines); i++) {
    draw_text(60, _y, lines[i]);
    _y += 20; // Move to the next line
}


// Set color and use draw_wrapped_text for each text section
draw_set_color(c_red);
draw_wrapped_text(450, 10, global.title, 100);
draw_wrapped_text(450, 200, global.question, 100);
draw_wrapped_text(450, 600, global.examples, 100);
draw_set_halign(fa_center);
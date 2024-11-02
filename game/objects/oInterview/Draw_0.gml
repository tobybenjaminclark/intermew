/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(1);

draw_self();
draw_set_halign(fa_center);
draw_text(x, y + 100, "Interview in Progress");
draw_text(x, y + 120, name);
draw_text(x, y + 140, type);
draw_text(x, y + 160, company);
draw_text(x, y + 180, role);

// Draw some debug stuff.
draw_text(5, room_height - 10, interview_index);
draw_text(100, room_height - 10, interview_path);
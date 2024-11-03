/// @description Insert description here
// You can write your code in this editor

if (alpha < 1) {
	alpha += 0.05;
} else {
	var _interview_path = "";
	var _interview_i = 0;
	with (oInterview) {
		_interview_path= interview_path;
		_interview_i=interview_index;
	}
	spawn_stats(_interview_path, _interview_i, "")
	instance_destroy(self);
}
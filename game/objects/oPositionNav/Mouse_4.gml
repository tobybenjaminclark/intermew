/// @description Go to Interview Nav Menu

audio_play_sound(sndSparkle, 0, false);
global.interview_path = interview_path;

with(oPositionNav){
	part_particles_clear(_ps)
	part_type_destroy(_ptype1)
	part_type_destroy(_ptype2)
	part_type_destroy(_ptype3)
	part_emitter_clear(_ps, _pemit1)
	part_emitter_clear(_ps, _pemit3)
	part_emitter_clear(_ps, _pemit3)	
}

with(oCamera){
	part_particles_clear(_ps)
	part_type_destroy(_ptype1)
	part_type_destroy(_ptype2)
	part_type_destroy(_ptype3)
	part_emitter_clear(_ps, _pemit1)
	part_emitter_clear(_ps, _pemit3)
	part_emitter_clear(_ps, _pemit3)
	part_system_position(_ps, - 1000, -1000);
	instance_destroy(id);
}

room_goto(rmMain);

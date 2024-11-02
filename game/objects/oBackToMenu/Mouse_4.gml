/// @description Insert description here
// You can write your code in this editor

game_restart();

try {
		with(oInterviewNav) {
		part_particles_clear(_ps)
		part_type_destroy(_ptype1)
		part_emitter_clear(_ps, _pemit1)
		part_particles_clear(_ps1)
		part_type_destroy(_ptype2)
		part_emitter_clear(_ps, _pemit2)
		
		instance_destroy(self);	
	}
}
catch(e){};
/// @description Insert description here
// You can write your code in this editor

//psInterview
_ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
_ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_sphere);
part_type_size(_ptype1, 1, 1, -0.005, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 3, 6, 0, 0);
part_type_direction(_ptype1, 230, 310, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 3, 0, false);

if(scre > 70) {
	part_type_colour3(_ptype1, $C4FF02, $8CFF00, $FFFFFF);
} else {
	part_type_colour3(_ptype1, $FF69B4, $FF1493, $FFB6C1);
}

part_type_alpha3(_ptype1, 0.351, 0.159, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 80, 80);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);




//psInterview
_ps1 = part_system_create();
part_system_draw_order(_ps1, true);

//Emitter
_ptype2 = part_type_create();
part_type_shape(_ptype2, pt_shape_sphere);
part_type_size(_ptype2, 1, 1, -0.005, 0);
part_type_scale(_ptype2, 1, 1);
part_type_speed(_ptype2, 3, 6, 0, 0);
part_type_direction(_ptype2, 46, 136, 0, 0);
part_type_gravity(_ptype2, 0, 270);
part_type_orientation(_ptype2, 0, 0, 3, 0, false);
if(scre > 70) {
	part_type_colour3(_ptype2, $C4FF02, $8CFF00, $FFFFFF);
} else {
	part_type_colour3(_ptype2, $FF69B4, $FF1493, $FFB6C1);
}
part_type_alpha3(_ptype2, 0.651, 0.659, 0);
part_type_blend(_ptype2, false);
part_type_life(_ptype2, 80, 80);

_pemit2 = part_emitter_create(_ps1);
part_emitter_region(_ps1, _pemit2, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps1, _pemit2, _ptype2, 1);

part_system_position(_ps1, x, y - 285);
part_system_position(_ps, x, y + 270);

// Camera properties
spd = 3; // Speed of camera movement

//psPlayer
_ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter1_1_1
_ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_flare);
part_type_size(_ptype1, 0.2, 1, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 0.3, 0.6, -0.01, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $99FFBB, $FF7FA7, $FFFFFF);
part_type_alpha3(_ptype1, 0.49, 0.408, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 80, 80);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);
part_emitter_interval(_ps, _pemit1, 0.1, 0.1, time_source_units_seconds);

//Emitter1_1
_ptype2 = part_type_create();
part_type_shape(_ptype2, pt_shape_flare);
part_type_size(_ptype2, 0.2, 1, -0.01, 0);
part_type_scale(_ptype2, 1, 1);
part_type_speed(_ptype2, 0.3, 0.7, -0.01, 0);
part_type_direction(_ptype2, 0, 360, 0, 0);
part_type_gravity(_ptype2, 0, 270);
part_type_orientation(_ptype2, 0, 0, 0, 0, false);
part_type_colour3(_ptype2, $F9CCFF, $9999FF, $FFFFFF);
part_type_alpha3(_ptype2, 0.49, 0.408, 0);
part_type_blend(_ptype2, false);
part_type_life(_ptype2, 80, 80);

_pemit2 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit2, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit2, _ptype2, 1);
part_emitter_interval(_ps, _pemit2, 0.1, 0.1, time_source_units_seconds);

//Emitter1
_ptype3 = part_type_create();
part_type_shape(_ptype3, pt_shape_flare);
part_type_size(_ptype3, 0.2, 1, 0, 0);
part_type_scale(_ptype3, 1, 1);
part_type_speed(_ptype3, 0.6, 1.2, -0.001, 0);
part_type_direction(_ptype3, 0, 360, 0, 0);
part_type_gravity(_ptype3, 0, 270);
part_type_orientation(_ptype3, 0, 0, 0, 0, false);
part_type_colour3(_ptype3, $D8FF00, $E2FFB2, $FFFFFF);
part_type_alpha3(_ptype3, 0.49, 1, 0);
part_type_blend(_ptype3, false);
part_type_life(_ptype3, 80, 80);

_pemit3 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit3, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit3, _ptype3, 1);
part_emitter_interval(_ps, _pemit3, 0.1, 0.1, time_source_units_seconds);



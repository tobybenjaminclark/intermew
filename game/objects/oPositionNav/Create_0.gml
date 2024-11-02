// Step Event for the object

// Calculate distance to oCamera
var cx = 0;
var cy = 0;
with(oCamera) {
	cx = x;
	cy = y;
}

fade_ratio = 0;
rot_spd = 2;
image_angle = random_range(0, 360);

var distance = point_distance(x, y, cx, cy);

// Define fade boundaries
var start_fade_distance = 220;
var end_fade_distance = 150;

// Calculate transparency
if (distance <= end_fade_distance) {
    image_alpha = 0; // Fully transparent
} else if (distance >= start_fade_distance) {
    image_alpha = 1; // Fully opaque
} else {
    var fade_ratio = (distance - end_fade_distance) / (start_fade_distance - end_fade_distance);
    image_alpha = fade_ratio;
}

//psStar
_ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter1_1
_ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_flare);
part_type_size(_ptype1, 1, 1, -0.01, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 2, 2, 0, 0);
part_type_direction(_ptype1, 0, 360, 1, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 2, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 0, 0.698, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 80, 80);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);

//Emitter1_2
_ptype2 = part_type_create();
part_type_shape(_ptype2, pt_shape_flare);
part_type_size(_ptype2, 1, 1, -0.01, 0);
part_type_scale(_ptype2, 1, 1);
part_type_speed(_ptype2, 2, 2, 0, 0);
part_type_direction(_ptype2, 0, 360, 1, 0);
part_type_gravity(_ptype2, 0, 270);
part_type_orientation(_ptype2, 0, 0, 2, 0, false);
part_type_colour3(_ptype2, $BFFF02, $CCF5FF, $FFFFFF);
part_type_alpha3(_ptype2, 0.098, 0.259, 0);
part_type_blend(_ptype2, false);
part_type_life(_ptype2, 150, 180);

_pemit2 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit2, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit2, _ptype2, 1);

//Emitter1
_ptype3 = part_type_create();
part_type_shape(_ptype3, pt_shape_flare);
part_type_size(_ptype3, 1, 1, -0.01, 0);
part_type_scale(_ptype3, 1, 1);
part_type_speed(_ptype3, 2, 2, 0, 0);
part_type_direction(_ptype3, 0, 360, 1, 0);
part_type_gravity(_ptype3, 0, 270);
part_type_orientation(_ptype3, 0, 0, 2, 0, false);
part_type_colour3(_ptype3, $B2F4FF, $CCF5FF, $FFFFFF);
part_type_alpha3(_ptype3, 0.478, 0.259, 0);
part_type_blend(_ptype3, false);
part_type_life(_ptype3, 150, 180);

_pemit3 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit3, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit3, _ptype3, 1);



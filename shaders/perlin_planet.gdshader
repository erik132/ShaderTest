shader_type canvas_item;

uniform float planet_angle = 0.0;

const vec4 black_color = vec4(0.0, 0.0, 0.0, 0.0);
const float planet_radius = 0.5;
const float planet_radius_square = 0.25;

void vertex() {
	// Called for every vertex the material is visible on.
}

mat2 rotation_matrix(float angle){
    return mat2(vec2(cos(angle),-sin(angle)),vec2(sin(angle),cos(angle)));
}

vec2 pseudo_random2(vec2 st) {
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43658.5453123);
}

float noise2(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( pseudo_random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( pseudo_random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( pseudo_random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( pseudo_random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

void fragment() {
	// Called for every pixel the material is visible on.
	float my_distance = pow(0.5 - UV.x, 2) + pow(0.5 - UV.y, 2);
	if (my_distance < planet_radius_square){
		vec2 translated = UV - 0.5;
		float z_coord = sqrt(planet_radius_square - pow(translated.x, 2) - pow(translated.y, 2));
		float level_radius = sqrt(planet_radius_square - pow(translated.y, 2));
		vec2 rotatated_vec = rotation_matrix(planet_angle) * vec2(translated.x, z_coord);
		float corrected_x_coord = (rotatated_vec.x/level_radius) * 0.5;
		
		//float new_color = noise2(vec2(corrected_x_coord, translated.y));
		float new_color = noise2(vec2(corrected_x_coord, translated.y)*5.0) - 0.0;
		
		COLOR = vec4(new_color, 0.0, 0.0, 1.0);
	}else{
		COLOR = black_color;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

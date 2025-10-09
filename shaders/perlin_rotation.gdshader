shader_type canvas_item;

uniform float planet_angle = 0.0;

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
	vec2 translated = UV - 0.5;
	float z_coord = sqrt(0.25 - pow(translated.x, 2));
	vec2 rotatated_vec = rotation_matrix(planet_angle) * vec2(translated.x, z_coord);
	vec2 corrected = vec2(rotatated_vec.x, UV.y) * 5.0;
	float end_color = noise2(corrected);
	COLOR = vec4(end_color, 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

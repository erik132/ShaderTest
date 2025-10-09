shader_type canvas_item;

uniform float planet_angle = 0.0;

const vec4 colors[] = {
			vec4(11.0/255.0, 9.0/255.0, 59.0/255.0, 1.0), 
			vec4(0.0, 75.0/255.0, 143.0/255.0, 1.0),
			vec4(61.0/255.0, 69.0/255.0, 46.0/255.0, 1.0),
			vec4(135.0/255.0, 111.0/255.0, 87.0/255.0, 1.0),
			vec4(108.0/255.0, 102.0/255.0, 90.0/255.0, 1.0)};

const vec4 black_color = vec4(0.0, 0.0, 0.0, 0.0);
const float planet_radius = 0.45;
const float atmosphere_radius = 0.5;
const float atmosphere_radius_square = 0.25;
const float planet_radius_square = 0.2025;
const vec4 atmosphere_colors[] = {
	vec4(0.0, 75.0/255.0, 143.0/255.0, 0.15),
	vec4(0.0, 75.0/255.0, 143.0/255.0, 0.20),
	vec4(0.0, 75.0/255.0, 143.0/255.0, 0.25)
	};

const float cloud_color_comp = 0.9;
const vec4 cloud_color = vec4(cloud_color_comp, cloud_color_comp, cloud_color_comp, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

mat2 rotation_matrix(float angle){
    return mat2(vec2(cos(angle),-sin(angle)),vec2(sin(angle),cos(angle)));
}

int select_palette(float elevation){
	return int(step(50.0/255.0, elevation) + step(100.0/255.0, elevation) + step(150.0/255.0, elevation) + step(200.0/255.0, elevation));
}

int select_atmosphere_palette(float small_distance) {
	return int(step(0.01583, small_distance) + step(0.03166, small_distance));
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
	float my_distance = pow(0.5 - UV.x, 2) + pow(0.5 - UV.y, 2);
	if (my_distance < planet_radius_square){ //Draw ground
		vec2 translated = UV - 0.5;
		float z_coord = sqrt(planet_radius_square - pow(translated.x, 2) - pow(translated.y, 2));
		float level_radius = sqrt(planet_radius_square - pow(translated.y, 2));
		vec2 rotatated_vec = rotation_matrix(planet_angle) * vec2(translated.x, z_coord);
		float corrected_x_coord = (rotatated_vec.x/level_radius) * 0.5;
		
		vec4 new_color = texture(TEXTURE, vec2(corrected_x_coord + 0.5, UV.y));
		float is_positive = step(0.0, rotatated_vec.y);
		float new_elevation = new_color.r * is_positive + new_color.b * (1.0 - is_positive);
		//COLOR = vec4(new_elevation, 0.0, 0.0, 1.0);
		COLOR = colors[select_palette(new_elevation)];
	} else if(my_distance < atmosphere_radius_square){ //Draw atmosphere
		COLOR = atmosphere_colors[select_atmosphere_palette(atmosphere_radius_square - my_distance)];
	}else{ // Void of space
		COLOR = black_color;
	}
	if(my_distance < atmosphere_radius_square){
		vec2 translated = UV - 0.5;
		float z_coord = sqrt(atmosphere_radius_square - pow(translated.x, 2) - pow(translated.y, 2));
		float level_radius = sqrt(atmosphere_radius_square - pow(translated.y, 2));
		vec2 rotatated_vec = rotation_matrix(planet_angle) * vec2(translated.x, z_coord);
		float corrected_x_coord = (rotatated_vec.x/level_radius) * 0.5;
		
		//float new_color = noise2(vec2(corrected_x_coord, translated.y)*7.0);
		float new_color = noise2(vec2(corrected_x_coord + 4.0, UV.y)*7.0);
		
		if(new_color > 0.05){
			COLOR = mix(COLOR, cloud_color, new_color + 0.4);
		}
	}
}
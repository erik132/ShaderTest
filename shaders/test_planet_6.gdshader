shader_type canvas_item;

uniform float planet_angle = 0.0;

const vec4 colors[] = {
			vec4(0.051, 0.110, 0.235, 1.0), // Deep ocean
			vec4(0.078, 0.169, 0.361, 1.0), // Ocean
			vec4(0.110, 0.235, 0.490, 1.0), // Ocean
			vec4(0.157, 0.329, 0.580, 1.0), // Shallow ocean
			vec4(0.235, 0.463, 0.698, 1.0), // Shallow water
			vec4(0.353, 0.580, 0.761, 1.0), // Very shallow water
			vec4(0.761, 0.698, 0.502, 1.0), // Beach sand
			vec4(0.639, 0.580, 0.420, 1.0), // Dry sand
			vec4(0.361, 0.510, 0.282, 1.0), // Grass green
			vec4(0.282, 0.420, 0.235, 1.0), // Forest green
			vec4(0.200, 0.329, 0.169, 1.0), // Dark forest
			vec4(0.420, 0.361, 0.282, 1.0), // Mountain brown
			vec4(0.502, 0.439, 0.361, 1.0), // Mountain rock
			vec4(0.698, 0.698, 0.698, 1.0), // Mountain grey
			vec4(0.878, 0.878, 0.878, 1.0), // Snow
			vec4(1.000, 1.000, 1.000, 1.0)  // Pure snow white
};

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

const float cloud_color_comp = 0.7;
const vec4 cloud_color = vec4(cloud_color_comp, cloud_color_comp, cloud_color_comp, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

mat2 rotation_matrix(float angle){
    return mat2(vec2(cos(angle),-sin(angle)),vec2(sin(angle),cos(angle)));
}

int select_palette(float elevation){
	return int(step(16.0/255.0, elevation) +
			step(32.0/255.0, elevation) +
			step(48.0/255.0, elevation) +
			step(64.0/255.0, elevation) +
			step(80.0/255.0, elevation) +
			step(96.0/255.0, elevation) +
			step(112.0/255.0, elevation) +
			step(128.0/255.0, elevation) +
			step(144.0/255.0, elevation) +
			step(160.0/255.0, elevation) +
			step(176.0/255.0, elevation) +
			step(192.0/255.0, elevation) + 
			step(208.0/255.0, elevation) +
			step(224.0/255.0, elevation) + 
			step(240.0/255.0, elevation));
}

int select_atmosphere_palette(float small_distance) {
	return int(step(0.01583, small_distance) + step(0.03166, small_distance));
}

vec2 pseudo_random2(vec2 st) {
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43658.5453123);
}

vec3 pseudo_random3(vec3 value){
	vec3 return_value = vec3( dot(value, vec3(127.1,311.7, 201.9) ),
				  dot(value, vec3(269.5,183.3, 367.7) ),
				  dot(value, vec3(245.1,367.7, 105.6) ) );
	return -1.0 + 2.0 * fract(sin(return_value) * 43758.5453123);
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

float noise3d(vec3 st) {
    vec3 i = floor(st);
    vec3 f = fract(st);

    vec3 u = f*f*(3.0-2.0*f);
	
	return mix(
     mix( mix( dot( pseudo_random3(i + vec3(0.0,0.0,0.0) ), f - vec3(0.0,0.0,0.0) ),
                dot( pseudo_random3(i + vec3(1.0,0.0,0.0) ), f - vec3(1.0,0.0,0.0) ), u.x),
        mix( dot( pseudo_random3(i + vec3(0.0,1.0,0.0) ), f - vec3(0.0,1.0,0.0) ),
                dot( pseudo_random3(i + vec3(1.0,1.0,0.0) ), f - vec3(1.0,1.0,0.0) ), u.x), u.y),
	mix( mix( dot( pseudo_random3(i + vec3(0.0,0.0,1.0) ), f - vec3(0.0,0.0,1.0) ),
                dot( pseudo_random3(i + vec3(1.0,0.0,1.0) ), f - vec3(1.0,0.0,1.0) ), u.x),
        mix( dot( pseudo_random3(i + vec3(0.0,1.0,1.0) ), f - vec3(0.0,1.0,1.0) ),
                dot( pseudo_random3(i + vec3(1.0,1.0,1.0) ), f - vec3(1.0,1.0,1.0) ), u.x), u.y), u.z);
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
		//float new_color = noise2(vec2(corrected_x_coord + 4.0, UV.y)*7.0);
		float new_color = noise3d(vec3(rotatated_vec.x, UV.y, rotatated_vec.y)*7.0);
		
		if(new_color > 0.05){
			COLOR = mix(COLOR, cloud_color, new_color + 0.4);
		}
	}
}
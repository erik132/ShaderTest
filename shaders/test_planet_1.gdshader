shader_type canvas_item;

uniform float planet_angle = 0.0;

const vec4 colors[] = {
			vec4(11.0/255.0, 9.0/255.0, 59.0/255.0, 1.0), 
			vec4(0.0, 75.0/255.0, 143.0/255.0, 1.0),
			vec4(61.0/255.0, 69.0/255.0, 46.0/255.0, 1.0),
			vec4(135.0/255.0, 111.0/255.0, 87.0/255.0, 1.0),
			vec4(108.0/255.0, 102.0/255.0, 90.0/255.0, 1.0)};

void vertex() {
	// Called for every vertex the material is visible on.
}

mat2 rotation_matrix(float angle){
    return mat2(vec2(cos(angle),-sin(angle)),vec2(sin(angle),cos(angle)));
}

int select_palette(float elevation){
	return int(step(50.0/255.0, elevation) + step(100.0/255.0, elevation) + step(150.0/255.0, elevation) + step(200.0/255.0, elevation));
	/*if (summer > 0.0){
		return 4;
	}else{
		return 1;
	}*/
	//return 4;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 translated = UV - 0.5;
	float z_coord = sqrt(0.25 - pow(translated.x, 2));
	vec2 rotatated_vec = rotation_matrix(planet_angle) * vec2(translated.x, z_coord);
	vec4 new_color = texture(TEXTURE, vec2(rotatated_vec.x + 0.5, UV.y));
	float is_positive = step(0.0, rotatated_vec.y);
	float new_elevation = new_color.r * is_positive + new_color.b * (1.0 - is_positive);
	//COLOR = vec4(new_elevation, 0.0, 0.0, 1.0);
	COLOR = colors[select_palette(new_elevation)];
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

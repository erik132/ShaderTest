shader_type canvas_item;

uniform float extra_angle = 0.0;

float draw_rectangle(vec2 up_left, vec2 bottom_right, vec2 current_pos) {
	vec2 decide = step(up_left, current_pos);
	vec2 decide2 = step(current_pos, bottom_right);
	
	return decide.x * decide.y * decide2.x * decide2.y;
}

mat2 rotation_matrix(float angle){
    return mat2(vec2(cos(angle),-sin(angle)),vec2(sin(angle),cos(angle)));
}

void vertex() {
	// Called for every vertex the material is visible on.
}

float draw_shape(vec2 current_pos){
	vec2 up_left = vec2(-0.2, -0.2);
	vec2 bottom_right = vec2(0.2, 0.2);
	return draw_rectangle(up_left, bottom_right, current_pos);
}

void fragment() {
	// Called for every pixel the material is visible on.
	//vec2 corrected_pos = 0.3 - UV;
	// * rotation radius * centre point offset.
	float x_extra = (cos(extra_angle) + 1.0) * 0.2 + 0.2;
	float y_extra = (sin(extra_angle) + 1.0) * 0.2 + 0.2;
	vec2 corrected_pos = vec2(x_extra - UV.x, y_extra - UV.y);
	corrected_pos = rotation_matrix(extra_angle*5.0) * corrected_pos;
	COLOR = vec4(draw_shape(corrected_pos), 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

shader_type canvas_item;

const float range_sq = pow(0.07, 2);

float draw_controlled_point(float current_x, float  current_y, float  point_x, float  point_y) {
	return step(pow(point_x - current_x, 2) + pow(point_y - current_y, 2), range_sq) * 0.2;
}

float draw_plot3(float dist) {    
    return smoothstep(0.35, 0.39, dist) - smoothstep(0.4, 0.45, dist);
}

float plot_circle(vec2 coords) {
	//float angle = PI * (1.0 - coords.x);
	//float angle = PI * (1.0 - coords.x);
	//float x = (cos(angle) + 1.0) * 0.5;
	//float y = (sin(angle) + 1.0) * 0.5;
	
	float angle1 = acos(coords.x * 2.0 - 1.0);
	float angle2 = asin(coords.y * 2.0 - 1.0);
	
	return step(abs(angle2-angle1), 0.1);
}

float plot_circle2(vec2 coords) {
	return draw_plot3(distance(coords, vec2(0.5, 0.5)));
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = vec4(plot_circle2(UV), 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

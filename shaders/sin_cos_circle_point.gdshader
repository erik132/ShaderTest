shader_type canvas_item;

uniform float angle = 0.0;
const float range_sq = pow(0.1, 2);

float draw_plot(float x, float y) {    
    return smoothstep(0.02, 0.0, abs(y - x));
}

float draw_controlled_point(float current_x, float  current_y, float  point_x, float  point_y) {
	return step(pow(point_x - current_x, 2) + pow(point_y - current_y, 2), range_sq) * 0.2;
}

float plot_point(vec2 coords) {
	float x = (cos(angle) + 1.0) * 0.5;
	float y = (sin(angle) + 1.0) * 0.5;
	//return draw_plot(coords.x, y);
	return draw_controlled_point(coords.x, coords.y, x, y);
}

float plot_center_circle(vec2 coords){
	return draw_controlled_point(coords.x, coords.y, 0.5, 0.5);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = vec4(plot_point(UV), 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

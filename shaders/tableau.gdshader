shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

float draw_rectangle(vec2 up_left, vec2 bottom_right, vec2 current_pos) {
	vec2 decide = step(up_left, current_pos);
	vec2 decide2 = step(current_pos, bottom_right);
	
	return decide.x * decide.y * decide2.x * decide2.y;
}

float plot_red(vec2 coords) {
	float first_rect = draw_rectangle(vec2(0.5, 0.5), vec2(0.7, 0.7), coords);
	float second_rect = draw_rectangle(vec2(0.5, 0.75), vec2(0.7, 0.95), coords);
	float third_rect = draw_rectangle(vec2(0.75, 0.5), vec2(0.95, 0.95), coords);
	float first_yellow_rect = draw_rectangle(vec2(0.75, 0.3), vec2(0.95, 0.45), coords);
	float first_white_rect = draw_rectangle(vec2(0.3, 0.05), vec2(0.45, 0.45), coords);
	return max(max(max(max(first_rect, second_rect), third_rect), first_yellow_rect), first_white_rect);
}

float plot_green(vec2 coords){
	float first_rect = draw_rectangle(vec2(0.5, 0.05), vec2(0.7, 0.45), coords);
	float first_yellow_rect = draw_rectangle(vec2(0.75, 0.3), vec2(0.95, 0.45), coords);
	float first_cyan_rect = draw_rectangle(vec2(0.05, 0.5), vec2(0.45, 0.95), coords);
	float first_white_rect = draw_rectangle(vec2(0.05, 0.3), vec2(0.45, 0.45), coords);
	return max(max(max(first_rect, first_yellow_rect), first_cyan_rect), first_white_rect);
}

float plot_blue(vec2 coords) {
	float first_rect = draw_rectangle(vec2(0.75, 0.05), vec2(0.95, 0.25), coords);
	float first_cyan_rect = draw_rectangle(vec2(0.05, 0.5), vec2(0.45, 0.95), coords);
	float first_white_rect = draw_rectangle(vec2(0.05, 0.05), vec2(0.45, 0.45), coords);
	return max(max(first_rect, first_cyan_rect), first_white_rect);
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = vec4(plot_red(UV), plot_green(UV), plot_blue(UV), 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

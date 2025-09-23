shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

float draw_plot(float x, float y) {    
    return smoothstep(0.02, 0.0, abs(y - x));
}

float draw_plot2(float x, float y) {
	return 1.0 - step(0.02, abs(y - x));
}

float draw_plot3(float x, float y) {    
    return smoothstep(0.4, 0.5, abs(y - x)) - smoothstep(0.5, 0.6, abs(y - x));
}

float plot_linear(vec2 coords) {
	return draw_plot(coords.x, coords.y);
}

float plot_square(vec2 coords) {    
	return draw_plot(pow(coords.x, 3), coords.y);
}

float plot_grid(vec2 coords) {
	return draw_plot(abs(cos(coords.x * 2.0 * PI)), abs(sin(coords.y * 2.0 * PI)));
}

float plot_circle_small(vec2 coords) {
	return draw_plot(pow(coords.x, 2), -pow(coords.y, 2));
}

float plot_diamond(vec2 coords) {
	return draw_plot2(abs(cos(coords.x * 1.0 * PI)), abs(sin(coords.y * 1.0 * PI)));
}

float plot_sin(vec2 coords) {
	return draw_plot(abs(sin(coords.x * 2.0 * PI)), coords.y);
}

float clamp_plot(vec2 st) {
	return clamp(abs(st.y - st.x), 0.0, 1.0);
}

//smoothstep output is always between 0 and 1.
//The line on the screen is drawn by having the first smoothstep go form 0 -> 1 
//while the other is 0 and then having the other go from 0 -> 1 turning the 
//final output to 0.
float plot_fade(vec2 st) {
	return smoothstep(0.4, 0.5, st.x) - smoothstep(0.5, 0.6, st.x);
}

void fragment() {
	COLOR = vec4(plot_grid(UV), 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

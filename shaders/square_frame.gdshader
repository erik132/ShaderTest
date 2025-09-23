shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

float plot_frame(vec2 coords){
	vec2 decide = step(vec2(0.2), coords);
	vec2 decide2 = step(vec2(0.2), 1.0 - coords);
	return decide.x * decide.y * decide2.x * decide2.y;
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = vec4(plot_frame(UV), 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

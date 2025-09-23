shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float x = pow(UV.x, 2)/UV.y;
	vec2 mid_vector = vec2(x, UV.y);
	mid_vector = mid_vector *2.-1.;
	float len = length(abs(mid_vector)-.4);
	//float len = length(mid_vector);
	float color_red = fract(len*10.0);
	//float color_red = len;
	COLOR = vec4(color_red, 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

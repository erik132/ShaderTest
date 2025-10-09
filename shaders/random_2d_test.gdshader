shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

float pseudo_random(vec2 coords) {
	return fract(sin(dot(coords, vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 adjusted = UV * 15.0;
	vec2 floored = floor(adjusted);
	COLOR = vec4(pseudo_random(floored), 0.0, 0.0, 1.0);
	
	//COLOR = vec4(pseudo_random(UV), 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

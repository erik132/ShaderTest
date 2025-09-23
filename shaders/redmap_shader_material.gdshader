shader_type canvas_item;
uniform float progress = 0.0;
uniform float vertex_offset = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX -= vec2(vertex_offset, 0.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 here = vec2(pow(0.25 + progress - UV.x, 2), pow(0.25 - (UV.y / 2.0), 2));
	float dist = sqrt(here.x + here.y);
	if(dist > 0.25){
		COLOR.a = 0.0;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

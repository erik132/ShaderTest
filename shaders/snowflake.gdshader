shader_type canvas_item;

uniform float extra_angle = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 pos = 0.5 - UV;
	float r = length(pos);
	float a = atan(pos.y, pos.x);
	float f = cos(a*3.0 + extra_angle);
	//f = abs(cos(a*3.0));
	//COLOR = vec4(f, 0.0, 0.0, 1.0 );
	
	COLOR = vec4(smoothstep(f,f+0.02,r), 0.0, 0.0, 1.0 );
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

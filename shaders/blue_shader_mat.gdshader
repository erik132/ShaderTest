shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
	//VERTEX += vec2(cos(TIME)*100.0, sin(TIME)*100.0);
	//VERTEX += vec2(10.0, 0.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
	//COLOR = texture(TEXTURE, UV); // Read from texture again.
	//COLOR.b = 0.9; //set blue channel to 1.0
	//COLOR = vec4(UV, 0.5, 1.0);
	vec2 here = vec2(pow(0.5 - UV.x, 2), pow(0.5 -UV.y, 2));
	float dist = sqrt(here.x + here.y);
	if(dist > 0.5){
		COLOR.a = 0.0;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

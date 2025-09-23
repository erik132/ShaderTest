shader_type canvas_item;

uniform float extra_angle = 0.0;


mat2 rotate2d(float _angle){
    return mat2(vec2(cos(_angle),-sin(_angle)),vec2(sin(_angle),cos(_angle)));
}

float draw_box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

float draw_cross(vec2 st, float size) {
	return max(draw_box(st, vec2(size, size/6.0)), draw_box(st, vec2(size/6.0, size)));
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//vec2 translation = vec2(cos(extra_angle), sin(extra_angle)) * 0.2;
	vec2 translation = vec2(0.5);
	vec2 translated = UV - translation;
	translated = rotate2d(extra_angle) * translated;
	translated += translation;
	float red = draw_cross(translated, 0.4);
	COLOR = vec4(red, 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

float pseudo_random(vec2 coords) {
	return fract(sin(dot(coords, vec2(12.9898,78.233))) * 43758.5412123);
}

vec2 pseudo_random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

float noise1 (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = pseudo_random(i);
    float b = pseudo_random(i + vec2(1.0, 0.0));
    float c = pseudo_random(i + vec2(0.0, 1.0));
    float d = pseudo_random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float noise2(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( pseudo_random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( pseudo_random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( pseudo_random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( pseudo_random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 corrected = UV * 5.0;
	
	float end_color = noise2(corrected) - 0.0;
	COLOR = vec4(end_color, 0.0, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

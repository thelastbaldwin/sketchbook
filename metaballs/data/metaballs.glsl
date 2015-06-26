#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER

uniform vec2 positions[6];
uniform float radius;

void main(){
	vec4 color = vec4(1.0, 0.0, 0.0, 1.0);
	float d = distance(gl_FragCoord.xy, vec2(positions[5], positions[6])/radius);
	gl_FragColor = mix(vec4(0.0, 0.0, 0.0, 1.0), color, d);
}
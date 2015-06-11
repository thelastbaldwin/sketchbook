#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 resolution;
varying vec4 vertTexCoord;

void main() {
	vec2 center = resolution/2.0;
	float r = distance(gl_FragCoord.xy, center);
	float theta = atan(gl_FragCoord.y + center.y, gl_FragCoord.x + center.x);
	vec2 p = r * vec2(cos(theta), sin(theta));
	p /= resolution;
	gl_FragColor = texture2D(texture, p);
}
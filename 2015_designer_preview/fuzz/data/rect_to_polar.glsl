#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 resolution;
uniform vec2 center;
varying vec4 vertTexCoord;

void main() {
	float r = distance(gl_FragCoord.xy, center)/1.5;
	float theta = atan(gl_FragCoord.y + center.y, gl_FragCoord.x + center.x);
	vec2 p = r * vec2(cos(theta), sin(theta));
	p /= resolution;
	gl_FragColor = texture2D(texture, p);
}
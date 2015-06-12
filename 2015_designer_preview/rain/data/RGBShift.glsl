/* adapted from felixturner / http://airtight.cc/ */

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


uniform sampler2D texture;

uniform float angle;
uniform float amount;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(){

	vec2 offset = amount * vec2( cos(angle), sin(angle));
	vec4 cr = texture2D(texture, vertTexCoord.xy + offset);
	vec4 cga = texture2D(texture, vertTexCoord.xy);
	vec4 cb = texture2D(texture, vertTexCoord.xy - offset);
	gl_FragColor = vec4(cr.r, cga.g, cb.b, cga.a) * vertColor;
}
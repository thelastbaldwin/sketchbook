#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float spacing;
uniform float size;
uniform float blur;
uniform vec2 resolution;
varying vec4 vertTexCoord;

void main() {
	vec2 count = resolution/spacing;
	vec2 p = floor(vertTexCoord.xy*count)/count;
	vec4 color = texture2D(texture, p);
	vec2 pos = mod(gl_FragCoord.xy, vec2(spacing)) - vec2(spacing/2.0);
	float dist_squared = dot(pos, pos);
	gl_FragColor = mix(color, vec4(0.0), smoothstep(size, size + blur, dist_squared));
}
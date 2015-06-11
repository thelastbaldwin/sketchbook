#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER


uniform sampler2D texture;
uniform sampler2D tex2;

uniform float mix;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(){

	vec4 tex2Color = texture2D(tex2, vertTexCoord.xy);
	vec4 textureColor = texture2D(texture, vertTexCoord.xy);
	gl_FragColor = mix(tex2Color, textureColor, mix);
}
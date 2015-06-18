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

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 invertColor(vec3 c){
	return vec3(1.0 - c.r, 1.0 - c.g, 1.0 - c.b);
}

void main(){

	vec4 tex2Color = texture2D(tex2, vertTexCoord.xy);
	//tex2Color = vec4(invertColor(tex2Color.rgb), 1.0);
	vec4 textureColor = texture2D(texture, vertTexCoord.xy);

	if(rgb2hsv(tex2Color.rgb).b > 0.1){
		gl_FragColor = mix(tex2Color, textureColor, mix);
	}else{
		//discard;
		//gl_FragColor = mix(textureColor, tex2Color, mix);
		gl_FragColor = vec4(vec3(0.0), 1.0);
	}
	
}
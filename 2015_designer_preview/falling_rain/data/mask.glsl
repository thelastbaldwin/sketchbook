#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER
 
uniform sampler2D texture;
uniform sampler2D mask;
 
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


float brightness(vec4 color){
	float m = max(color.r, color.g);
	m = max(m, color.b);
	return m;
}
 
void main() {
	float threshold = 0.7;
  vec4 texColor = texture2D(texture, vertTexCoord.st).rgba;
  vec4 maskColor = texture2D(mask, vec2(vertTexCoord.s, vertTexCoord.t)).rgba;
  //If a PImage is used instead of PGraphics, must invert Y axis
  //vec4 maskColor = texture2D(mask, vec2(vertTexCoord.s, 1.0-vertTexCoord.t)).rgba;
  // if(brightness(maskColor) > threshold){
  //   gl_FragColor = texColor;
  // }else{
  //   gl_FragColor = vec4(0.0, 1.0, 0.0, 0.0);
  // }
  if(rgb2hsv(maskColor.rgb).b < threshold){
  	gl_FragColor = texColor;
  	// gl_FragColor = mix(texColor, vec4(0.0, 0.0, 0.0, 0.0), brightness(maskColor));;
  }else{
  	gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
  }
}
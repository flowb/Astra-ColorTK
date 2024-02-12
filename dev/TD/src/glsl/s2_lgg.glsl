// Lift Gamma Gain shader
// wip ... s2gfx 20230913

//#define EPSILON 1.0e-10

uniform vec4 lift, gamma, gain;
uniform vec3 offset, RX1, RX2, RX3;
uniform vec2 cTemp, green, white;
uniform float lmix, saturation, contrast, tint;

// yrgb and luminance related shared functions
#include "/core/shaders/y"
#include "/core/shaders/color"


vec3 lMx(vec4 inColor)
{
	// Lmix
	return lum_mix( inColor.rgb, inColor.a, luma( inColor.rgb, vec3(RX1.y,RX2.y,RX3.y) ), lmix );
}

out vec4 fragColor;
void main()
{
	vec4 color = texture( sTD2DInputs[0], vUV.st );
	mat3 RGBtoXYZ = mat3(RX1,RX2,RX3);
	
	vec3 outCol = RGBtoXYZ * color.rgb;
	float Y = outCol.y;
	
	vec2 startW = CCT_Kang2002(cTemp.s);
	vec2 targetW = CCT_Kang2002(cTemp.s-cTemp.t);
	vec2 shift = xy_to_XY(targetW)-xy_to_XY(startW);
	outCol.xz += shift.st;
	
	vec2 tintShift = mix(vec2(0.0),xy_to_XY(green)-xy_to_XY(white),tint);
	outCol.xz += tintShift;

	outCol = inverse(RGBtoXYZ) * outCol;
	outCol = mix(color.rgb,outCol,Y);
	
	//saturation
	outCol = mix(vec3(Y),outCol, saturation);
	
	//contrast
	outCol = mix(vec3(0.5),outCol, contrast);

	// gamma
	outCol = pow( outCol, 1.0 / lMx( gamma ) );
	
	// gain
	outCol *= lMx( gain );
	
	// lift
	vec3 lTmp = 0.5 * lMx( lift );
	outCol = outCol * ( 1.5 - lTmp ) + lTmp - 0.5;

	// offset
	outCol += offset;

	// touchdesigner stuff
	//outCol = clamp(outCol, vec3(0.),vec3(1.0));
	outCol = max(vec3(0.0),outCol);
	fragColor = TDOutputSwizzle( vec4(outCol,color.a) );
}


#define EPSILON 1.0e-10

float luma(vec3 inRGB, vec3 lumCOE)
{
	return dot(inRGB, lumCOE);
}

vec3 lum_mix(vec3 inRGB, float Y, float inLUM, float lMIX)
{
	return mix(
		inRGB,
		inRGB * (Y/inLUM+EPSILON), // scale intensity by delta-Y
		lMIX
		);
}


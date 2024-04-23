// title:   primary grading controls shader
// author:  florian mosleh <flo@s2gfx.com>
// version: 2.0
// date:    20240423 (mtx range input fix)

//@implements: sampler2D
struct LiftGammaGain {
    sampler2D sampler;

    //@ label: "mix_LiftGammaGain", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 1
    float mix;

    //@ label: "Lum Mix", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 1
    float lmix;

    //@ label: "Temp", editor: range, min: -4000, max: 4000, range_min: -4000, range_max: 4000, range_default: 0
    float Temp;

    //@ label: "Tint", editor: range, min: -100, max: 100, range_min: -100, range_max: 100, range_default: 0
    float Tint;

    //@ label: "Contrast", editor: range, min: 0, max: 8, range_min: 0, range_max: 8, range_default: 1
    float Contrast;

    //@ label: "Saturation", editor: range, min: 0, max: 8, range_min: 0, range_max: 8, range_default: 1
    float Saturation;

    //@ label: "lift R", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float lift_r;
    //@ label: "lift G", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float lift_g;
    //@ label: "lift B", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float lift_b;
    //@ label: "lift Y", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float lift_y;

    //@ label: "gamma R", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float gamma_r;
    //@ label: "gamma G", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float gamma_g;
    //@ label: "gamma B", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float gamma_b;
    //@ label: "gamma Y", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float gamma_y;

    //@ label: "gain R", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float gain_r;
    //@ label: "gain G", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float gain_g;
    //@ label: "gain B", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float gain_b;
    //@ label: "gain Y", editor: range, min: -1, max: 4, range_min: -1, range_max: 4, range_default: 1
    float gain_y;

    //@ label: "offset R", editor: range, min: -10, max: 10, range_min: -10, range_max: 10, range_default: 0.0
    float offset_r;
    //@ label: "offset G", editor: range, min: -10, max: 10, range_min: -10, range_max: 10, range_default: 0.0
    float offset_g;
    //@ label: "offset B", editor: range, min: -10, max: 10, range_min: -10, range_max: 10, range_default: 0.0
    float offset_b;

    //@ label: "RX1 0", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.4123908
    float RX1_0;
    //@ label: "RX1 1", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.21263901
    float RX1_1;
    //@ label: "RX1 2", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.01933082
    float RX1_2;
    //@ label: "RX2 0", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.35758434
    float RX2_0;
    //@ label: "RX2 1", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.71516868
    float RX2_1;
    //@ label: "RX2 2", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.11919478
    float RX2_2;
    //@ label: "RX3 0", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.18048079
    float RX3_0;
    //@ label: "RX3 1", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.07219232
    float RX3_1;
    //@ label: "RX3 2", editor: range, min: -2, max: 2, range_min: -2, range_max: 2, range_default: 0.95053215
    float RX3_2;

    //@ label: "WhiteK", editor: range, min: 1000, max: 8000, range_min: 1000, range_max: 8000, range_default: 6500
    float WhiteK;

    //@ label: "White X", editor: range, min: 0.0, max: 1.0, range_min: 0.0, range_max: 1.0, range_default: 0.3127
    float White_X;
    //@ label: "White Y", editor: range, min: 0.0, max: 1.0, range_min: 0.0, range_max: 1.0, range_default: 0.329
    float White_Y;

    //@ label: "Green X", editor: range, min: 0.0, max: 1.0, range_min: 0.0, range_max: 1.0, range_default: 0.3
    float Green_X;
    //@ label: "Green Y", editor: range, min: 0.0, max: 1.0, range_min: 0.0, range_max: 1.0, range_default: 0.6
    float Green_Y;


};

vec2 CCT_Kang2002(float temp)
{
	float temp3 = pow(temp,3.0);
	float temp2 = pow(temp,2.0);

	float cie_x =
		mix(
			-0.2661239 * pow(10.0,9.0) / temp3
			- 0.2343589 * pow(10.0,6.0) / temp2
			+ 0.8776956 * pow(10.0,3.0) / temp
			+ 0.179910,
			-3.0258469 * pow(10.0,9.0) / temp3
			+ 2.1070379 * pow(10.0,6.0) / temp2
			+ 0.2226347 * pow(10.0,3.0) / temp
			+ 0.24039,
			step(4000.0, temp)
		);

	float x3 = pow(cie_x,3.0);
	float x2 = pow(cie_x,2.0);

	float cie_y =
		mix(
			-1.1063814 * x3 - 1.34811020 * x2 + 2.18555832 * cie_x - 0.20219683,
			mix(
				-0.9549476 * x3 - 1.37418593 * x2 + 2.09137015 * cie_x - 0.16748867,
				3.0817580 * x3 - 5.8733867 * x2 + 3.75112997 * cie_x - 0.37001483,
				step(4000.0,temp)
			),
			step(2222.0,temp)
		);
	return vec2(cie_x,cie_y);
}

vec2 xy_to_XY(vec2 xy)
{
    float e = 1.0e-10;
	return vec2(xy.x/(xy.y+e), (1.0-xy.x-xy.y)/(xy.y+e));
}

float luma(vec3 inRGB, vec3 lumCOE)
{
	return dot(inRGB, lumCOE);
}

vec3 lum_mix(vec3 inRGB, float Y, float inLUM, float lMIX)
{
	return mix(
		inRGB,
        inRGB * (Y/inLUM),
		lMIX
		);
}

vec3 lMx(vec4 inColor, vec3 lumCOE, float lmix)
{
	// Lmix
	return lum_mix( inColor.rgb, inColor.a, luma( inColor.rgb, lumCOE ), lmix );
}

vec4 texture(LiftGammaGain s, vec2 tex_coords) {
    vec4 o_color = texture(s.sampler, tex_coords);
    vec4 color = o_color;

    vec4 lift = vec4(s.lift_r, s.lift_g, s.lift_b, s.lift_y);
    vec4 gamma = vec4(s.gamma_r, s.gamma_g, s.gamma_b, s.gamma_y);
    vec4 gain = vec4(s.gain_r, s.gain_g, s.gain_b, s.gain_y);
    vec3 yCOE = vec3(s.RX1_1,s.RX2_1,s.RX3_1);
    mat3 RGBtoXYZ = mat3( vec3(s.RX1_0,s.RX1_1,s.RX1_2), vec3(s.RX2_0,s.RX2_1,s.RX2_2), vec3(s.RX3_0,s.RX3_1,s.RX3_2) );

    //convert to XYZ
    vec3 outCol = RGBtoXYZ * color.rgb;
    float Y = outCol.y;

    //temperature
    vec2 startW = CCT_Kang2002(s.WhiteK);
	vec2 targetW = CCT_Kang2002(s.WhiteK-s.Temp);
	vec2 shift = xy_to_XY(targetW)-xy_to_XY(startW);
    outCol.xz += shift.st;

    //tint
    vec2 tintShift = mix(vec2(0.0),xy_to_XY(vec2(s.Green_X,s.Green_Y))-xy_to_XY(vec2(s.White_X,s.White_Y)),s.Tint);
	outCol.xz += tintShift;

    //convert back to RGB and mix result by luminance
    outCol = inverse(RGBtoXYZ) * outCol;
	outCol = mix(color.rgb,outCol,Y);

    //saturation
	outCol = mix(vec3(Y),outCol, s.Saturation);

	//contrast
	outCol = mix(vec3(0.5),outCol, s.Contrast);

	// gamma
	outCol = pow( outCol, vec3(1.0) / lMx( gamma, yCOE, s.lmix ) );

    // gain
	outCol *= lMx( gain, yCOE, s.lmix );

	// lift
	outCol = outCol * ( 1.5 - 0.5 * lMx( lift, yCOE, s.lmix ) ) + 0.5 * lMx( lift, yCOE, s.lmix ) - 0.5;

    //offset
    outCol += vec3( s.offset_r, s.offset_g, s.offset_b);

    //prevent negative values
    outCol = max(vec3(0.0),outCol);

	return mix(o_color, vec4(outCol,o_color.a), s.mix);

}

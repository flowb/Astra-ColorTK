// Astra ColorTK: CurveLumVsHue
// AUTOGENERATED by Shader Build System
// DATE: 20231106_095129
#define TWO_PI 6.28318530718
#define PI 3.141592653589
#define epsilon 1.0e-10



float pwcos(float graph_x, vec2 a, vec2 b)
{
	return ( cos((graph_x-a.x)/(b.x-a.x+epsilon)*PI)-1.0)*0.5*(a.y-b.y)+a.y;

}
float xim( float x, float a, float b )
{
	return mix(b,a,x);

}
float graphEval(float graph_x, CurveLumVsHue gp)
{
	vec2 p1 = vec2(gp.p1_X, gp.p1_Y);
	vec2 p2 = vec2(gp.p2_X, gp.p2_Y);
	vec2 p3 = vec2(gp.p3_X, gp.p3_Y);
	vec2 p4 = vec2(gp.p4_X, gp.p4_Y);
	vec2 p5 = vec2(gp.p5_X, gp.p5_Y);
	vec2 p6 = vec2(gp.p6_X, gp.p6_Y);
	vec2 p7 = vec2(gp.p7_X, gp.p7_Y);
	vec2 p8 = vec2(gp.p8_X, gp.p8_Y);
	vec2 p9 = vec2(gp.p9_X, gp.p9_Y);
	vec2 p10 = vec2(gp.p10_X, gp.p10_Y);
	vec2 p11 = vec2(gp.p11_X, gp.p11_Y);
	vec2 p12 = vec2(gp.p12_X, gp.p12_Y);
	vec2 p13 = vec2(gp.p13_X, gp.p13_Y);
	vec2 p14 = vec2(gp.p14_X, gp.p14_Y);
	vec2 p15 = vec2(gp.p15_X, gp.p15_Y);
	vec2 p16 = vec2(gp.p16_X, gp.p16_Y);
	vec2 p17 = vec2(gp.p17_X, gp.p17_Y);
	vec2 p18 = vec2(gp.p18_X, gp.p18_Y);
	vec2 p19 = vec2(gp.p19_X, gp.p19_Y);

		float c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,eval;

	// TL/DR: the var "eval" is the graph evaluation for
	// the specified Hue.
	
	int M = int(floor(gp.precMode));

	switch (M) {
		case 0:
			c0 = pwcos(graph_x,p1,p2);
			c1 = pwcos(graph_x,p2,p3);
			c2 = pwcos(graph_x,p3,p4);
			c3 = pwcos(graph_x,p4,p5);
			c4 = pwcos(graph_x,p5,p6);
			c5 = pwcos(graph_x,p6,p19);

			eval = 
			xim(float(graph_x > p1.x && graph_x < p2.x),  c0,
			xim(float(graph_x > p2.x && graph_x < p3.x),  c1,
			xim(float(graph_x > p3.x && graph_x < p4.x),  c2,
			xim(float(graph_x > p4.x && graph_x < p5.x),  c3,
			xim(float(graph_x > p5.x && graph_x < p6.x),  c4,
		 	c5)))));
			break;

		case 1:
			c0 = pwcos(graph_x,p1,p2);
			c1 = pwcos(graph_x,p2,p3);
			c2 = pwcos(graph_x,p3,p4);
			c3 = pwcos(graph_x,p4,p5);
			c4 = pwcos(graph_x,p5,p6);
			c5 = pwcos(graph_x,p6,p7);
			c6 = pwcos(graph_x,p7,p8);
			c7 = pwcos(graph_x,p8,p9);
			c8 = pwcos(graph_x,p9,p10);
			c9 = pwcos(graph_x,p10,p11);
			c10 = pwcos(graph_x,p11,p12);
			c11 = pwcos(graph_x,p12,p19);

			eval = 
			xim(float(graph_x > p1.x && graph_x < p2.x),  c0,
			xim(float(graph_x > p2.x && graph_x < p3.x),  c1,
			xim(float(graph_x > p3.x && graph_x < p4.x),  c2,
			xim(float(graph_x > p4.x && graph_x < p5.x),  c3,
			xim(float(graph_x > p5.x && graph_x < p6.x),  c4,
			xim(float(graph_x > p6.x && graph_x < p7.x),  c5,
			xim(float(graph_x > p7.x && graph_x < p8.x),  c6,
			xim(float(graph_x > p8.x && graph_x < p9.x),  c7,
			xim(float(graph_x > p9.x && graph_x < p10.x),  c8,
			xim(float(graph_x > p10.x && graph_x < p11.x),  c9,
			xim(float(graph_x > p11.x && graph_x < p12.x),  c10,
		 	c11)))))))))));
			break;

		case 2:
			c0 = pwcos(graph_x,p1,p2);
			c1 = pwcos(graph_x,p2,p3);
			c2 = pwcos(graph_x,p3,p4);
			c3 = pwcos(graph_x,p4,p5);
			c4 = pwcos(graph_x,p5,p6);
			c5 = pwcos(graph_x,p6,p7);
			c6 = pwcos(graph_x,p7,p8);
			c7 = pwcos(graph_x,p8,p9);
			c8 = pwcos(graph_x,p9,p10);
			c9 = pwcos(graph_x,p10,p11);
			c10 = pwcos(graph_x,p11,p12);
			c11 = pwcos(graph_x,p12,p13);
			c12 = pwcos(graph_x,p13,p14);
			c13 = pwcos(graph_x,p14,p15);
			c14 = pwcos(graph_x,p15,p16);
			c15 = pwcos(graph_x,p16,p17);
			c16 = pwcos(graph_x,p17,p18);
			c17 = pwcos(graph_x,p18,p19);

			eval = 
			xim(float(graph_x > p1.x && graph_x < p2.x),  c0,
			xim(float(graph_x > p2.x && graph_x < p3.x),  c1,
			xim(float(graph_x > p3.x && graph_x < p4.x),  c2,
			xim(float(graph_x > p4.x && graph_x < p5.x),  c3,
			xim(float(graph_x > p5.x && graph_x < p6.x),  c4,
			xim(float(graph_x > p6.x && graph_x < p7.x),  c5,
			xim(float(graph_x > p7.x && graph_x < p8.x),  c6,
			xim(float(graph_x > p8.x && graph_x < p9.x),  c7,
			xim(float(graph_x > p9.x && graph_x < p10.x),  c8,
			xim(float(graph_x > p10.x && graph_x < p11.x),  c9,
			xim(float(graph_x > p11.x && graph_x < p12.x),  c10,
			xim(float(graph_x > p12.x && graph_x < p13.x),  c11,
			xim(float(graph_x > p13.x && graph_x < p14.x),  c12,
			xim(float(graph_x > p14.x && graph_x < p15.x),  c13,
			xim(float(graph_x > p15.x && graph_x < p16.x),  c14,
			xim(float(graph_x > p16.x && graph_x < p17.x),  c15,
			xim(float(graph_x > p17.x && graph_x < p18.x),  c16,
		 	c17))))))))))))))))); //<--- more parentheses than a can of pringles
			break;
	}
	return eval;

}


float channelDelta( vec3 rgb)
{
	return max(rgb.r, max(rgb.g, rgb.b)) - min(rgb.r, min(rgb.g, rgb.b));

}
mat3 rotMtx(float angle)
{
    float cosA = cos(angle);
    float sinA = sin(angle);
    float sqrtThird = sqrt(1.0 / 3.0);
    
    mat3 mtxR = mat3(
        cosA + (1.0 - cosA) / 3.0,
        sqrtThird * (1.0 - cosA) - sqrtThird * sinA,
        sqrtThird * (1.0 - cosA) + sqrtThird * sinA,
        
        sqrtThird * (1.0 - cosA) + sqrtThird * sinA,
        cosA + (1.0 - cosA) / 3.0,
        sqrtThird * (1.0 - cosA) - sqrtThird * sinA,
        
        sqrtThird * (1.0 - cosA) - sqrtThird * sinA,
        sqrtThird * (1.0 - cosA) + sqrtThird * sinA,
        cosA + (1.0 - cosA) / 3.0
    );
    
    return mtxR;

}
vec3 rotateHue(vec3 color, float angle, vec3 yCOE)
{
    mat3 mtxR = rotMtx(angle);
    //vec3 gray = vec3(0.5, 0.5, 0.5);
    vec3 lum = vec3(yCOE.x, yCOE.y, yCOE.z);

    // Translate to lum, rotate, then translate back
    return mtxR * (color - lum) + lum;

}
vec3 satScale(vec3 chansRGB, float scale)
{
	float avg = dot(chansRGB, vec3(1.0))/3.;
	return vec3( avg ) + ( (chansRGB - vec3(avg)) * vec3(scale) );

}
vec3 adjustHUE( vec3 color, float eval, vec3 yCOE )
{
    float adjHue = 4. * PI * ( eval - 0.5 );
	float lum = dot( color.rgb, yCOE );
	float inputSat = channelDelta( color.rgb ) / ( lum + epsilon );
	vec3 col = rotateHue( color.rgb, adjHue, vec3( lum ) );

	// rescale saturation to match input
	float outputSat = channelDelta( col.rgb ) / ( dot( col.rgb, yCOE ) + epsilon );
	col.rgb = satScale( col.rgb, inputSat / ( outputSat + epsilon ));

	// rescale output luminance to initial
	col.rgb *= vec3( lum / ( dot( col.rgb, yCOE ) + epsilon) );

    return col;

}


// Generic Curve for Astra Color TK
// "main" section for Pixera Shader
// florian mosleh <flo@s2gfx.com>
// 1.0 20231102

//@implements: sampler2D
struct CurveLumVsHue {
	sampler2D sampler;

	//@ label: "mix_CurveLumVsHue", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 1
	float mix;

	//@ label: "Precision Mode", editor: range, min: 0, max: 2, range_min: 0, range_max: 2, range_default: 0
	float precMode;

	//@ label: "p1 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 0.00
	float p1_X;
	//@ label: "p1 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p1_Y;

	//@ label: "p2 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 0.1666
	float p2_X;
	//@ label: "p2 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p2_Y;

	//@ label: "p3 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 0.333
	float p3_X;
	//@ label: "p3 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p3_Y;

	//@ label: "p4 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 0.50
	float p4_X;
	//@ label: "p4 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p4_Y;

	//@ label: "p5 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 0.666
	float p5_X;
	//@ label: "p5 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p5_Y;

	//@ label: "p6 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 0.8333
	float p6_X;
	//@ label: "p6 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p6_Y;

	//@ label: "p7 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 1.1666
	float p7_X;
	//@ label: "p7 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p7_Y;

	//@ label: "p8 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 1.1666
	float p8_X;
	//@ label: "p8 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p8_Y;

	//@ label: "p9 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 1.333
	float p9_X;
	//@ label: "p9 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p9_Y;

	//@ label: "p10 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 1.50
	float p10_X;
	//@ label: "p10 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p10_Y;

	//@ label: "p11 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 1.666
	float p11_X;
	//@ label: "p11 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p11_Y;

	//@ label: "p12 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 1.8333
	float p12_X;
	//@ label: "p12 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p12_Y;

	//@ label: "p13 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 2.00
	float p13_X;
	//@ label: "p13 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p13_Y;

	//@ label: "p14 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 2.1666
	float p14_X;
	//@ label: "p14 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p14_Y;

	//@ label: "p15 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 2.333
	float p15_X;
	//@ label: "p15 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p15_Y;

	//@ label: "p16 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 2.50
	float p16_X;
	//@ label: "p16 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p16_Y;

	//@ label: "p17 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 2.666
	float p17_X;
	//@ label: "p17 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p17_Y;

	//@ label: "p18 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 2.8333
	float p18_X;
	//@ label: "p18 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p18_Y;

	//@ label: "p19 X", editor: range, min: 0, max: 10, range_min: 0, range_max: 10, range_default: 2.8333
	float p19_X;
	//@ label: "p19 Y", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 0.5
	float p19_Y;

    //@ label: "RX1 0", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.4123908
    float RX1_0;
    //@ label: "RX1 1", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.21263901
    float RX1_1;
    //@ label: "RX1 2", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.01933082
    float RX1_2;
    //@ label: "RX2 0", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.35758434
    float RX2_0;
    //@ label: "RX2 1", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.71516868
    float RX2_1;
    //@ label: "RX2 2", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.11919478
    float RX2_2;
    //@ label: "RX3 0", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.18048079
    float RX3_0;
    //@ label: "RX3 1", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.07219232
    float RX3_1;
    //@ label: "RX3 2", editor: range, min: -1, max: 1, range_min: -1, range_max: 1, range_default: 0.95053215
    float RX3_2;

};


vec4 texture( CurveLumVsHue s, vec2 tex_coords )
{
	//input
    vec4 color = texture( s.sampler, tex_coords );
	vec3 yCOE = vec3( s.RX1_1, s.RX2_1, s.RX3_1 );


	//graph_x
	float graph_x = dot(color.rgb, yCOE);


	//graph
	float eval = graphEval(graph_x + epsilon, s);


	//adjustment
    vec4 col = vec4( adjustHUE( color.rgb, eval, yCOE ), color.a );
    

	//output
	return mix( color, col, s.mix );
}

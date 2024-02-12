// Generic Curve for Astra Color TK
// "main" section for Pixera Shader
// florian mosleh <flo@s2gfx.com>
// 1.0 20231102

//@implements: sampler2D
struct FILTER_ID {
	sampler2D sampler;

	//@ label: "mix_FILTER_ID", editor: range, min: 0, max: 1, range_min: 0, range_max: 1, range_default: 1
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


vec4 texture( FILTER_ID s, vec2 tex_coords )
{
	//input
    vec4 color = texture( s.sampler, tex_coords );
	vec3 yCOE = vec3( s.RX1_1, s.RX2_1, s.RX3_1 );


	//graph_x
	float graph_x = GRAPH_FUNC;


	//graph
	float eval = EVAL_FUNC(graph_x + epsilon, s);


	//adjustment
    vec4 col = vec4( ADJUST_FUNC( color.rgb, eval, yCOE ), color.a );
    

	//output
	return mix( color, col, s.mix );
}
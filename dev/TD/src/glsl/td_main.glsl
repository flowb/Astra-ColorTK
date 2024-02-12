graphPoints points = {
	precMode,
	p1.x, p1.y,
	p2.x, p2.y,
	p3.x, p3.y,
	p4.x, p4.y,
	p5.x, p5.y,
	p6.x, p6.y,
	p7.x, p7.y,
	p8.x, p8.y,
	p9.x, p9.y,
	p10.x, p10.y,
	p11.x, p11.y,
	p12.x, p12.y,
	p13.x, p13.y,
	p14.x, p14.y,
	p15.x, p15.y,
	p16.x, p16.y,
	p17.x, p17.y,
	p18.x, p18.y,
	p19.x, p19.y
};

out vec4 fragColor;
void main()
{
	//input
	vec4 color = texture(sTD2DInputs[0], vUV.st);
	vec3 yCOE = vec3( RX1.y, RX2.y, RX3.y );
	

	//graph_x = SAT
	float graph_x = GRAPH_FUNC;


	//graph
	float eval = EVAL_FUNC(graph_x + epsilon, points );
	

	//LUM adjustment
	vec4 col = vec4( ADJUST_FUNC( color.rgb, eval, yCOE ), color.a );
	

	//output
	fragColor = TDOutputSwizzle( col );
}
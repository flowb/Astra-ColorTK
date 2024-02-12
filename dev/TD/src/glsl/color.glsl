#define TWO_PI 6.28318530718
#define PI 3.141592653589
#define epsilon 1.0e-10


vec2 c2p( vec2 in_coords, float offset_angle)
{
    in_coords = vec2(0.5) - in_coords;
    float angle = atan( in_coords.y, in_coords.x ) + offset_angle;
    float radius = length(in_coords) * 2.0;
    return vec2(angle, radius);
}

vec2 p2c( float angle, float mag ) //input is angle and radial distance
{
    float _angle = angle*TWO_PI;
    return vec2( mag*cos(_angle), mag*sin(_angle))+0.5;
}

float tri( float x, float scale )
{
    return abs(mod(x,scale)-(scale*0.5));
}


vec3 hue2rgb(float hue)
{
    float r = abs(hue * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(hue * 6.0 - 2.0);
    float b = 2.0 - abs(hue * 6.0 - 4.0);
    return clamp(vec3(r,g,b),0.0,1.0);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// RGB to HSV conversion requires branching in order to determine 
// which third of the color wheel you're in based on which RGB
// channel is highest. element-wise operations on the gpu can be
// used to reduce the number of branching operations. this code is
// derived from https://gist.github.com/983/e170a24ae8eba2cd174f
// the original work is by Sam Hocevar and Emil Persson. -fm
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = c.g < c.b ? vec4(c.bg, K.wz) : vec4(c.gb, K.xy);
    vec4 q = c.r < p.x ? vec4(p.xyw, c.r) : vec4(c.r, p.yzx);

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
	float shift = 0.0000001; //this is needed to resolve some spikes at primaries
    return vec3(shift+abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// convenience function for when you just want the hue as a float
float rgb2hue( vec3 c )
{
    return rgb2hsv(c).x;
}

// planckian locus plotting function: adapted from colour-science.org
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

// XYZ/xyY formulae: adapted from brucelindbloom.com
vec2 xy_to_XY(vec2 xy)
{
    float e = 1.0e-10;
	return vec2(xy.x/(xy.y+e), (1.0-xy.x-xy.y)/(xy.y+e));
}

vec2 XYZ_to_xy(vec3 XYZ)
{
    float e = 1.0e-10;
    float sumXYZ = dot(XYZ,vec3(1.))+e;
    return vec2(XYZ.x/sumXYZ, XYZ.y/sumXYZ);
}

// RGB native hue shift
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

float channelDelta( vec3 rgb)
{
	return max(rgb.r, max(rgb.g, rgb.b)) - min(rgb.r, min(rgb.g, rgb.b));
}

float normalizedSat( vec3 rgb )
{
	// offset negative channel values
	vec3 minRGB = min(vec3(0.0),rgb);
	vec3 maxRGB = rgb - minRGB;

	return channelDelta(maxRGB) / max(maxRGB.r,max(maxRGB.g,maxRGB.b));
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

vec3 adjustSAT( vec3 color, float eval, vec3 yCOE )
{
    float adjSat = eval * 2.0;
    float lum = dot(color.rgb, yCOE);
	return mix( vec3( lum ), color.rgb, adjSat );
}

vec3 adjustLUM( vec3 color, float eval, vec3 yCOE )
{
    float adjY = 1. + 2.*( eval - 0.5 );
	return color.rgb * adjY;
}
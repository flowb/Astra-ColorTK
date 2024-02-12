
// Copied from http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
// the site looks like it's about to be swallowed up by 
// the internet spambot equivalent of the gray goo scenario 
// so I figured it was worth preserving.

// Fast branchless RGB to HSV conversion in GLSL
// Some time ago I devised an original algorithm to convert from RGB to HSV using very few CPU instructions and I wrote a small article about it.
// When looking for a GLSL or HLSL conversion routine, I have found implementations of my own algorithm. However they were almost all straightforward, failing to take full advantage of the GPU’s advanced swizzling features.
// So here it is, the best version I could come up with:

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

//Update: ​Emil Persson suggests using the ternary operator explicitly to force compilers into using a fast conditional move instruction:

    vec4 p = c.g < c.b ? vec4(c.bg, K.wz) : vec4(c.gb, K.xy);
    vec4 q = c.r < p.x ? vec4(p.xyw, c.r) : vec4(c.r, p.yzx);
//And because a lot of people get it wrong, too, here is the reverse operation in GLSL. It is the algorithm almost everyone uses (or should use):

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
//Porting to HLSL is straightforward: replace vec3 and vec4 with float3 and float4, mix with lerp, fract with frac, and clamp(…, 0.0, 1.0) with saturate(…).

// Posted: 2013-07-27 15:23 (Updated: 2013-07-28 11:54)
// Author: sam
// Categories: glsl optim
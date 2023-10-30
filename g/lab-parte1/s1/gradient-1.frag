#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;

void main()
{
	vec2 tex = vtexCoord;	
	float aux = mix(tex.s,tex.t,0.5);
	fragColor = frontColor;
}

#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

void main()
{
    fragColor = vec4(0,0.65,0,1);
    if (distance(vec2(vtexCoord.x,vtexCoord.y*0.5), vec2(0.25,0.25)) < 0.2) fragColor = vec4(1,1,1,1);
    if (distance(vec2(vtexCoord.x,vtexCoord.y*0.5), vec2(0.375,0.25)) < 0.2) fragColor = vec4(0,0.65,0,1);
    if (vtexCoord.x >= 0.625 && vtexCoord.x <= 0.875 &&
    	vtexCoord.y >= 0.25 && vtexCoord.y <= 0.75) fragColor = vec4(1,1,1,1);
}

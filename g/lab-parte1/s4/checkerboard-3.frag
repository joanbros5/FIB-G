#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

vec4 grey = vec4(0.8);
vec4 black = vec4(0);

uniform float n = 8;

void main()
{
    float x = fract(vtexCoord.x*n);
    float y = fract(vtexCoord.y*n);
    
    if(x>0.1 && y>0.1) fragColor = grey;
    else fragColor = black;
}

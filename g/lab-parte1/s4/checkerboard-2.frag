#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float n = 8;

vec4 grey = vec4(0.8);
vec4 black = vec4(0);

void main()
{
    int x = int(mod(vtexCoord.x/(1.0/n),2));
    int y = int(mod(vtexCoord.y/(1.0/n),2));
    
    if(x==y) fragColor = grey;
    else fragColor = black;
}

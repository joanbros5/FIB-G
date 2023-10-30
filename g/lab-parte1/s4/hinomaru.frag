#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

vec4 white = vec4(1);
vec4 red = vec4(1,0,0,1);

void main()
{
    float d = length(vec2(vtexCoord.xy-0.5));
    
    if(d <= 0.2) fragColor = red;
    else fragColor = white;
}

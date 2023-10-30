#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform float n = 8.f;

void main()
{
    if (mod(floor(vtexCoord.x*n) + floor(vtexCoord.y*n) , 2) == 1) 
        fragColor = vec4(0,0,0,0);
    else fragColor = vec4(0.8);
}

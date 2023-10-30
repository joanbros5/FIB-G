#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

void main()
{
    if (mod(floor(vtexCoord.x*8) + floor(vtexCoord.y*8) , 2) == 1) 
        fragColor = vec4(0,0,0,0);
    else fragColor = vec4(0.8);
}

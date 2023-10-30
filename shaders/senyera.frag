#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

void main()
{
    if ((mod(floor(vtexCoord.x*9), 9) == 1) || (mod(floor(vtexCoord.x*9), 9) == 3) ||
    	(mod(floor(vtexCoord.x*9), 9) == 5) || (mod(floor(vtexCoord.x*9), 9) == 7)) 
        fragColor = vec4(1,0,0,0);
    else fragColor = vec4(1,1,0,0);
}

#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

uniform sampler2D colorMap;

void main()
{
    vec4 color;

    if (mod(floor(vtexCoord.x*6), 6) == 0)
        color = texture(colorMap, vec2(vtexCoord.s * 0.6 + 0.4, vtexCoord.t));
    else if (mod(floor(vtexCoord.x*6), 6) == 1)
    	color = texture(colorMap, vec2(vtexCoord.s * 0.6 + 0.7, vtexCoord.t));
    else if (mod(floor(vtexCoord.x*6), 6) == 2)
    	color = texture(colorMap, vec2(vtexCoord.s * 0.6 + 0.8, vtexCoord.t));
    else if (mod(floor(vtexCoord.x*6), 6) == 3)
    	color = texture(colorMap, vec2(vtexCoord.s * 0.6 + 0.4, vtexCoord.t));
    else if (mod(floor(vtexCoord.x*6), 6) == 4)
    	color = texture(colorMap, vec2(vtexCoord.s * 0.6 + 0.2, vtexCoord.t));
    else 
    	color = texture(colorMap, vec2(vtexCoord.s * 0.6 + 0.2, vtexCoord.t));
    
    if (color.a < 0.5) fragColor = vec4(1,1,0,1);
    else fragColor = vec4(0,0,1,1);
}

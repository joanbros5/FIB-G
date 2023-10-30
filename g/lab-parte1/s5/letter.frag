#version 330 core

in vec2 vtexCoord;

//in vec4 frontColor;
out vec4 fragColor;

vec4 red = vec4(1,0,0,1);
vec4 black = vec4(0,0,0,1);

void main()
{
    fragColor = black;
    if(vtexCoord.t > 0.4) {
    	if(vtexCoord.s<0.2 || vtexCoord.s>0.8) fragColor = red;
    }
    else if(vtexCoord.t > 0.2) {
    	if(vtexCoord.s>0.2 && vtexCoord.s<0.4) fragColor = red;
    	else if(vtexCoord.s>0.6 && vtexCoord.s<0.8) fragColor = red;
    }
    else if(vtexCoord.s>0.4 && vtexCoord.s<0.6) fragColor = red;
    
    //fragColor = frontColor;
}

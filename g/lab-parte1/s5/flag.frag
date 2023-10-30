#version 330 core

in vec2 vtexCoord;

out vec4 fragColor;

vec4 blue = vec4(0.2,0,0.8,1);
vec4 red = vec4(0.8,0,0,1);
vec4 green = vec4(0,0.8,0,1);
vec4 yellow = vec4(0.8,1,0,1);

void main()
{
    vec2 texCoord = vtexCoord*vec2(1,0.75);	//Redimensionamos tambien las texturas
    						//tal y como hemos hecho en el VS
    
    if(texCoord.t < 0.25) fragColor = blue;
    else if(texCoord.t < 0.5) fragColor = yellow;
    else fragColor = green;
    
    float radi = 0.25;
    vec2 centre = vec2(0.5,0.375);
    if(distance(texCoord, centre) < radi) fragColor = red;
}

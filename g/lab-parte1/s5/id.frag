#version 330 core

uniform sampler2D digits;

in vec2 vtexCoord;

in vec4 frontColor;
out vec4 fragColor;

void main()
{
    float a = 1.0/6;
    vec2 texCoord = vtexCoord;
    
    texCoord = texCoord * vec2(1.0/10,1);	//Cogemos la primera 1/10 de la textura
    texCoord = texCoord * vec2(6,1);		//Repetimos la textura 6 veces
    
    if(vtexCoord.s > 0*a) texCoord.s += 0.4;
    if(vtexCoord.s > 1*a) texCoord.s += 0.1;
    if(vtexCoord.s > 2*a) texCoord.s += 0.7;
    if(vtexCoord.s > 3*a) texCoord.s += 0.7;
    if(vtexCoord.s > 4*a) texCoord.s += 0.0;
    if(vtexCoord.s > 5*a) texCoord.s += 0.6;
    
    
    fragColor = frontColor * texture(digits, texCoord);
    if(fragColor.a < 0.5) discard;
}

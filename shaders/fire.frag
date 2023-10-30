#version 330 core

in vec4 frontColor;
out vec4 fragColor;

//Cosas nuevas
uniform sampler2D myMap;
in vec2 vtexCoord;

uniform float time;

uniform float slice=0.1;
uniform sampler2D sampler0;
uniform sampler2D sampler1;
uniform sampler2D sampler2;
uniform sampler2D sampler3;

void main()
{   
    if (int(time/slice) % 4 == 0) 
    fragColor = frontColor * texture(sampler0, vtexCoord);
    else if (int(time/slice) % 4 == 1) 
    fragColor = frontColor * texture(sampler1, vtexCoord);
    else if (int(time/slice) % 4 == 2) 
    fragColor = frontColor * texture(sampler2, vtexCoord);
    else if (int(time/slice) % 4 == 3) 
    fragColor = frontColor * texture(sampler3, vtexCoord);
}

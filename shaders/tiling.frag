#version 330 core

in vec4 frontColor;
out vec4 fragColor;

//Cosas nuevas
uniform sampler2D myMap;
in vec2 vtexCoord;

void main()
{
    fragColor = frontColor * texture(myMap, vtexCoord);
}

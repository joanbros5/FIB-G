#version 330 core

in vec4 frontColor;
out vec4 fragColor;

//Cosas nuevas
uniform sampler2D myMap;
in vec2 vtexCoord;
uniform float time;

void main()
{
    vec4 color = texture(myMap, vec2(vtexCoord.s / 8, vtexCoord.t / 6));
    fragColor = frontColor * color.a * color;
}

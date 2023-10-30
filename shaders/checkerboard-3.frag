#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform float n = 8.f;

void main()
{
    if (mod(floor(vtexCoord.x*9*n), 9) == 0 || mod(floor(vtexCoord.y*9*n), 9) == 0) {
            fragColor = vec4(0);
    }
    else fragColor = vec4(0.8);
}

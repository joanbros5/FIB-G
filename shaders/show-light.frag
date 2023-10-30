#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

uniform sampler2D colorMap;
in vec2 gtexCoord;

void main()
{
    if (gtexCoord != vec2(-1,-1)) {
        vec4 C = texture(colorMap, gtexCoord);
        if ((C * C.a).a < 0.1) discard;
    	else fragColor = C * C.a;
    }
    else fragColor = gfrontColor;
}

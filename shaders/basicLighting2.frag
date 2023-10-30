#version 330 core

in vec4 frontColor;
out vec4 fragColor;

//Cosas nuevas
in vec3 fnormal;

uniform mat3 normalMatrix;

void main()
{
    vec3 N = normalize(normalMatrix * fnormal);
    fragColor = frontColor * N.z;
}

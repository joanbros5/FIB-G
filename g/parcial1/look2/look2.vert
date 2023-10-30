#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float angle = 0.5;

void main()
{
    mat3 look = mat3(	vec3(cos(angle), 0, -sin(angle)),
			vec3(0, 1, 0),
			vec3(sin(angle), 0, cos(angle)));
    
    vec3 V = look * vertex;	//Despues de rotación
    float t = smoothstep(1.45,1.55,vertex.y);
    
    vec3 looky = mix(vertex,V,t);
    
    vec3 Nrot = look*normal;
    vec3 Ny = mix(normal,Nrot,t);
    
    vec3 N = normalize(normalMatrix * Ny);
    frontColor = vec4(1,1,1,1.0) * N.z;
    
    gl_Position = modelViewProjectionMatrix * vec4(looky,1.0);
}






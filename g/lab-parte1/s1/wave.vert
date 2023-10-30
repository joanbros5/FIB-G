#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;
uniform float amp = 0.5;
uniform float freq = 0.25;

const float pi = 3.141592;

void main()
{
    float aux = amp * sin(pi*2*freq*time + amp*sin(vertex.y));
    
    mat3 wave = mat3(	vec3(1, 0, 0),
    			vec3(0, cos(aux), sin(aux)),
    			vec3(0, -sin(aux), cos(aux)));
    
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * N.z;
    
    vec3 V = wave * vertex;
    gl_Position = modelViewProjectionMatrix * vec4(V, 1.0);
}

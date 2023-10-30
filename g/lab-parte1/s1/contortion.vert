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

float aux = (vertex.y-0.5)*sin(time) * float((vertex.y >= 0.5));

mat4 cont = mat4(	vec4(1, 0, 0, 0),
			vec4(0, cos(aux), sin(aux), 0),
			vec4(0, -sin(aux), cos(aux), 0),
			vec4(0, 0, 0, 1));
			
mat4 trans = mat4(	vec4(1, 0, 0, 0),
			vec4(0, 1, 0, 0),
			vec4(0, 0, 1, 0),
			vec4(0, -1, 0, 1));


void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * inverse(trans) * cont*trans * vec4(vertex, 1.0);
}

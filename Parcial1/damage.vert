#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

uniform int num = 4;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

float rand(vec2 co) {
	return cos(sin(dot(co, vec2(12.9898, 78.233))) * 437.585453) / 2 + 0.5;
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    
    //Dividir el model en "num" seccions per component
    for (int i = 0; i < num; ++i) {
    	for (int j = 0; j < num; ++j) {
    	    for (int k = 0; k < num; ++k) {
    	    	//Trobar vrnd
    	    }
    	}
    }
    
    //Aquí s'hauria de ver que el vertex prengui per valor el vrnd més proper, no em dona temps :(
    vec3 vrnd = vertex;
    
    frontColor = vec4(rand(vrnd.xy),rand(vrnd.yz),rand(vrnd.zx),1.0) * N.z;
    
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}

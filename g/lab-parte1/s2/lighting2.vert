#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform vec4 matAmbient;	//Ka
uniform vec4 matDiffuse;	//Kd
uniform vec4 matSpecular;	//Ks
uniform float matShininess;	//s

uniform vec4 lightAmbient;	//Ia
uniform vec4 lightDiffuse;	//Id
uniform vec4 lightSpecular;	//Is
uniform vec4 lightPosition;	//

vec4 light(vec3 N, vec3 V, vec3 L) {
	N = normalize(N);
	V = normalize(V);
	L = normalize(L);
	
	vec3 R = normalize(2*dot(N,L)*N-L);
	float NdotL = max(0, dot(N, L));
	float RdotV = max(0, dot(R, V));
	float aux1 = NdotL;
	
	float aux2;
	if(NdotL > 0) aux2 = pow(RdotV, matShininess);
	else aux2 = 0;
	
	return matAmbient*lightAmbient + matDiffuse*lightDiffuse*aux1 + 				matSpecular*lightSpecular*aux2;
}

void main()
{
    vec3 P = (modelViewMatrix * vec4(vertex,1.0)).xyz;
    vec3 N = normalize(normalMatrix * normal);
    vec3 V = -P;			//Vector vertex cap a la camara
    vec3 L = lightPosition.xyz - P;	//Vector cap a la font de llum
    frontColor = light(N,V,L);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex.xyz, 1.0);
}

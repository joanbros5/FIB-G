#version 330 core

in vec3 N;
in vec3 P;
out vec4 fragColor;

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
    vec3 L = lightPosition.xyz - P;
    vec3 V = -P;
    
    fragColor = light(N,V,L);
}

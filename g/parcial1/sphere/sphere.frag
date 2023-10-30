#version 330 core

in vec2 vtexCoord;
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

uniform int mode = 2;

vec4 black = vec4(0,0,0,1);

void mode0() {
    float d = length(vec2(vtexCoord.x-0.0, vtexCoord.y-0.0));
    
    if(d <= 1.0) fragColor = black;
    else discard;
}

void mode1(vec3 N) {
    fragColor = vec4(N.z);
}

void mode2(vec3 N, vec3 V, vec3 L) {
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

    fragColor = matAmbient*lightAmbient + matDiffuse*lightDiffuse*aux1 + 				matSpecular*lightSpecular*aux2;
}

void main()
{
    mode0();
    
    vec3 P = vec3(vtexCoord.s, vtexCoord.t, sqrt(1-pow(vtexCoord.s,2)-pow(vtexCoord.t,2)));
    vec3 N = P;
    if(mode==1) mode1(N);
    if(mode==2) {
	P = (modelViewMatrix * vec4(P.xyz,1)).xyz;	//eye space
    	N = normalMatrix * N;				//eye space
    	vec3 V = -P;
	vec3 L = lightPosition.xyz - P;
	mode2(N,V,L);
    }
}

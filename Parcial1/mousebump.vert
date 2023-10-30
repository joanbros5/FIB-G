#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform int test = 0;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform vec2 mousePosition;
uniform float radius = 300;
uniform vec2 viewport;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec4 vermell = vec4(1,0,0,1);
uniform vec4 blanc = vec4(1,1,1,1);

vec2 getMousePositionWindowSpace() {
    if(test == 0) return mousePosition;
    if(test == 1) return vec2(400,520);
    if(test == 2) return vec2(600,225);
    if(test == 3) return vec2(200,375);
    return vec2(400,300);
}


void main()
{
    //Calcul diagonal
    float diag = distance(boundingBoxMax, boundingBoxMin);
    float desp = diag * 0.03;
    
    vec3 N = normalize(normalMatrix * normal);
    
    //Calcul del vertex en window space
    vec4 projV = modelViewProjectionMatrix*vec4(vertex,1.0);
    vec3 clipV = projV.xyz;
    vec3 normV = normalize(clipV);
    vec2 windV = normV.xy * viewport;
    
    //Si no poso "-viewport/2" no surt on ha de sortir, no sé per què
    float d = distance(windV, getMousePositionWindowSpace() - viewport/2);
    
    float t = smoothstep(radius*0.8,radius*0.05,d);
    
    //Posició final del vertex
    vec3 newV = vertex + N * desp * t;
    
    frontColor = mix(blanc, vermell, t) * N.z;
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(newV, 1.0);
}

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

//Cosas nuevas

uniform vec4 lightAmbient;	// similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; 	// similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; 	// similar a gl_LightSource[0].specular
uniform vec4 lightPosition; 	// similar a gl_LightSource[0].position (sempre estarà en eye space)
uniform vec4 matAmbient; 	// similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse;	// similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular;	// similar a gl_FrontMaterial.specular
uniform float matShininess;	// similar a gl_FrontMaterial.shininess



void main()
{
    vec3 normSCO = normalMatrix * normal;
    vec4 vertexSCO = modelViewMatrix * vec4(vertex, 1.0);
    
    //Vector normal unitari
    vec3 N = normalize(normSCO);
    
    //Vector llum->vertex unitari
    vec3 L = normalize(lightPosition.xyz - vertexSCO.xyz);
    
    //Vector reflexió de L
    vec3 R = reflect(-L, N);
    
    //Vector vertex->OBS unitari
    vec3 V = normalize(-vertexSCO.xyz);
    
    //Calcul ambient
    vec4 colAmbient = lightAmbient * matAmbient;
     
    //Calcul difus
    vec4 colDifus = vec4(0);
    if (dot(L, N) > 0) colDifus = lightDiffuse * matDiffuse * max(0.0, dot(N, L));
    
    //Calcul spec
    vec4 colSpec = vec4(0);
    if (dot(R, V) >= 0 && dot(N, L) >= 0 ) colSpec = lightSpecular * matSpecular * pow(max(0.0, dot(R, V)), matShininess);
    			
    frontColor = colAmbient + colDifus + colSpec;
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1);
}

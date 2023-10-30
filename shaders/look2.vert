#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform float angle = 0.5;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

void main()
{
    //No hace falta
    //vec3 N = normalize(normalMatrix * normal);
    
    float t = smoothstep(1.45,1.55,vertex.y);
    
    
    //Rotació a l'eix Y utilitzant la matriu de rotacio
    vec3 newvertex;
    
    newvertex.x = vertex.x * cos(angle) + vertex.z * sin(angle);
    newvertex.y = vertex.y;
    newvertex.z = -vertex.x * sin(angle) + vertex.z * cos(angle);
    
    //Calcul de nova normal i color
    vec3 newnormal;
    
    newnormal.x = normal.x * cos(angle) + normal.z * sin(angle);
    newnormal.y = normal.y;
    newnormal.z = -normal.x * sin(angle) + normal.z * cos(angle);
    
    vec3 finalNormal = mix(normal, newnormal, t);
    
    /*
    Convertir a SCO y normalizar (multiplicar por inversa de 
    transpuesta de modelViewMatrix == normalMatrix)
    
    Si no se normaliza, el modelo va cambiando de colores según se rota
    */
    frontColor = vec4(vec3(normalize(normalMatrix*finalNormal).z),1.0);
    
    vtexCoord = texCoord;
    
    gl_Position = modelViewProjectionMatrix * vec4(mix(vertex, newvertex, t), 1.0);
}

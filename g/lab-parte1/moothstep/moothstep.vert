#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec2 mousePosition;
uniform float mouseOverrideX = -1;

uniform vec2 viewport = vec2(800,600);

mat3 set_look(float a) {
    mat3 look = mat3(	vec3(cos(a),0,-sin(a)),
    			vec3(0,1,0),
    			vec3(sin(a),0,cos(a)));
    return look;
}

void main()
{
    float x;;
    if(mousePosition.x<=viewport.x && mousePosition.x>=0) {
    	x = mousePosition.x;
    }
    else x = viewport.x/2;
    
    float a = -1 + (x/viewport.x)*2;
    
    mat3 look = set_look(a);
    vec3 p = look * vertex;
    
    float t = smoothstep(1.45,1.55,vertex.y);
    
    vec3 capy = mix(vertex,p,t);
    
    vec3 nrot = look*normal;
    vec3 normy = mix(normal,nrot,t);
    
    vec3 N = normalize(normalMatrix * normy);
    frontColor = vec4(1,1,1,1.0) * N.z;
    
    gl_Position = modelViewProjectionMatrix * vec4(capy,1.0);
}





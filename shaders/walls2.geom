#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;

uniform mat4 modelMatrixInverse;
uniform mat4 viewMatrixInverse;
uniform mat4 projectionMatrixInverse;
uniform mat4 modelViewMatrixInverse;
uniform mat4 modelViewProjectionMatrixInverse;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

bool inside(vec3 v, vec3 min, vec3 max) {
	return (v.x >= min.x && v.x <= max.x && v.y >= min.y && v.y <= max.y && v.z >= min.z && v.z <= max.z);
}

void pintaQuad(vec3 minV, vec3 maxV, vec4 color) {
    gfrontColor = color;
    
    //PLA X
    if (minV.x == maxV.x) {
    	float x = minV.x;
    
    	//Paint square
        gl_Position = modelViewProjectionMatrix*vec4(x, minV.y, minV.z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(x, maxV.y, minV.z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(x, minV.y, maxV.z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(x, maxV.y, maxV.z, 1);
        EmitVertex();
        
        EndPrimitive();
    } 
    
    //PLA Y
    if (minV.y == maxV.y) {
    	float y = minV.y;
    
    	//Paint square
        gl_Position = modelViewProjectionMatrix*vec4(minV.x, y, minV.z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(maxV.x, y, minV.z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(minV.x, y, maxV.z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(maxV.x, y, maxV.z, 1);
        EmitVertex();
        
        EndPrimitive();
    } 
    
    //PLA Z
    if (minV.z == maxV.z) {
    	float z = minV.z;
    
    	//Paint square
        gl_Position = modelViewProjectionMatrix*vec4(minV.x, minV.y, z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(maxV.x, minV.y, z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(minV.x, maxV.y, z, 1);
        EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(maxV.x, maxV.y, z, 1);
        EmitVertex();
        
        EndPrimitive();
    }  	   	
}

void main( void )
{
	vec4 white = vec4(1,1,1,1);
	vec4 yellow = vec4(1,1,0,1);
	vec4 red = vec4(1,0,0,1);
	vec4 green = vec4(0,1,0,1);
	vec4 blue = vec4(0,0,1,1);
	vec4 orange = vec4(1,0.6,0,1);
	
	if (gl_PrimitiveIDIn  == 0) {
		pintaQuad(boundingBoxMin, vec3(boundingBoxMax.x,boundingBoxMin.y,boundingBoxMax.z), green);
		pintaQuad(boundingBoxMin, vec3(boundingBoxMin.x,boundingBoxMax.y,boundingBoxMax.z), red);
		pintaQuad(boundingBoxMax, vec3(boundingBoxMax.x,boundingBoxMin.y,boundingBoxMin.z), red);
		pintaQuad(boundingBoxMin, vec3(boundingBoxMax.x,boundingBoxMax.y,boundingBoxMin.z), blue);
	}
	
	for( int i = 0 ; i < 3 ; i++ )
	{
		if (inside((modelViewMatrixInverse*vec4(0,0,0,1)).xyz, boundingBoxMin, boundingBoxMax)) {
			gfrontColor = 2*vfrontColor[i];
		}
		else {
			gfrontColor = vfrontColor[i];
		}
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
    
    
}

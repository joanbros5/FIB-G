#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

uniform vec3 boundingBoxMin;

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

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec4 v = gl_in[i].gl_Position;
		gl_Position = v;
		EmitVertex(); 
	}
	
	EndPrimitive();
	
	for( int i = 0 ; i < 3 ; i++ )
	{
		vec4 v = modelViewProjectionMatrixInverse*gl_in[i].gl_Position;
		gfrontColor = vec4(0);
		gl_Position = modelViewProjectionMatrix*vec4(v.x,boundingBoxMin.y,v.z,v.w);
		EmitVertex();
	}
    EndPrimitive();
}

#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

uniform vec4 lightPosition;

out vec2 gtexCoord;

uniform float w = 0.3;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 projectionMatrix;

void pintaQuad(vec3 minV, vec3 maxV, vec4 color, vec3 l) {
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
        gl_Position = vec4(minV.x, minV.y, z, 1);
        gtexCoord = vec2((minV.x - (l.x+w)) / 2*w, (minV.y - (l.y+w)) / 2*w);
        EmitVertex();
        gl_Position = vec4(maxV.x, minV.y, z, 1);
        gtexCoord = vec2((maxV.x - (l.x-w)) / 2*w, (minV.y - (l.y+w)) / 2*w);
        EmitVertex();
        gl_Position = vec4(minV.x, maxV.y, z, 1);
        gtexCoord = vec2((minV.x - (l.x+w)) / 2*w, (maxV.y - (l.y-w)) / 2*w);
        EmitVertex();
        gl_Position = vec4(maxV.x, maxV.y, z, 1);
        gtexCoord = vec2((maxV.x - (l.x-w)) / 2*w, (maxV.y - (l.y-w)) / 2*w);
        EmitVertex();

        EndPrimitive();
    }
}

void main( void )
{
	vec4 lightcoords = projectionMatrix*lightPosition;
	vec3 l = (lightcoords / lightcoords.w).xyz;
	
	for( int i = 0 ; i < 3 ; i++ )
	{
	        gtexCoord = vec2(-1,-1);
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
	EndPrimitive();
	
	if (gl_PrimitiveIDIn == 0) {
		pintaQuad(l - vec3(w,w,0),l + vec3(w,w,0),vec4(1,1,1,1), l);
	}
}

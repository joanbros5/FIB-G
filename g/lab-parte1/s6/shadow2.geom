#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewProjectionMatrixInverse;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

vec4 black = vec4(0,0,0,1);
vec4 cyan = vec4(0,1,1,1);

void floorVertex(bool x, bool z, vec3 rc, float r) {
	gfrontColor = cyan;
	if(x) rc.x += r;
	else rc.x -= r;
	
	if(z) rc.z += r;
	else rc.z -= r;
	
	gl_Position = modelViewProjectionMatrix*vec4(rc,1);
	EmitVertex();
}

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
    
    for(int i=0; i<3; i++) {
    	gfrontColor = black;
    	vec4 V = modelViewProjectionMatrixInverse * gl_in[i].gl_Position;
    	V.y = boundingBoxMin.y;
    	gl_Position = modelViewProjectionMatrix * V;
    	EmitVertex();
    }
    EndPrimitive();
    
    if(gl_PrimitiveIDIn==0) {
    	float r = length(boundingBoxMax+boundingBoxMin)/2;
    	vec3 rc = (boundingBoxMax+boundingBoxMin)/2;
    	rc.y = boundingBoxMin.y - 0.01;
    	
    	floorVertex(false,false,rc,r);
    	floorVertex(true,false,rc,r);
    	floorVertex(false,true,rc,r);
    	floorVertex(true,true,rc,r);
    	EndPrimitive();
    }
}

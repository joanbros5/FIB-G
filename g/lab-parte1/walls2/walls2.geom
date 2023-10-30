#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 viewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void drawVertex(vec3 v) {
	gl_Position = modelViewProjectionMatrix * vec4(v,1.0);
	EmitVertex();
}

void drawBox() {
	//Bottom green
	gfrontColor = vec4(0,1,0,0);
	drawVertex(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMax.z));
	drawVertex(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMax.z));
	drawVertex(vec3(boundingBoxMin));
	drawVertex(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMin.z));
	drawVertex(vec3(boundingBoxMin));
	EndPrimitive();
	
	//left red
	gfrontColor = vec4(1,0,0,0);
	drawVertex(vec3(boundingBoxMin));
	drawVertex(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMax.z));
	drawVertex(vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMin.z));
	drawVertex(vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMax.z));
	EndPrimitive();
	
	//right red
	gfrontColor = vec4(1,0,0,0);
	drawVertex(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMin.z));
	drawVertex(vec3(boundingBoxMax.x, boundingBoxMax.y, boundingBoxMin.z));
	drawVertex(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMax.z));
	drawVertex(vec3(boundingBoxMax.x, boundingBoxMax.y, boundingBoxMax.z));
	EndPrimitive();
	
	//bach blue
	gfrontColor = vec4(0,0,1,0);
	drawVertex(vec3(boundingBoxMin));
	drawVertex(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMin.z));
	drawVertex(vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMin.z));
	drawVertex(vec3(boundingBoxMax.x, boundingBoxMax.y, boundingBoxMin.z));
	EndPrimitive();
}

void main( void )
{
	float x = -viewMatrix[3][0];
	float y = -viewMatrix[3][1];
	float z = -viewMatrix[3][2];
	
	float maxx = boundingBoxMax.x;
	float minx = boundingBoxMin.x;
	float maxy = boundingBoxMax.y;
	float miny = boundingBoxMin.y;
	float maxz = boundingBoxMax.z;
	float minz = boundingBoxMin.z;
	
	for( int i = 0 ; i < 3 ; i++ )
	{
		if(x<=maxx && x>=minx && y<=maxy && y>=miny && z<=maxz && z>=minz) {
			gfrontColor = 2 * vfrontColor[i];
		}
		else gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
    
    if(gl_PrimitiveIDIn==0) {
    	drawBox();
    }
    EndPrimitive();
}

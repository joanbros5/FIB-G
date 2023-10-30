#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 128) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

in int gl_PrimitiveIDIn;

uniform float time;

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

mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

vec3 rotate(vec3 v, vec3 axis, float angle) {
	mat4 m = rotationMatrix(axis, angle);
	return (m * vec4(v, 1.0)).xyz;
}


void main( void )
{
	vec4 white = vec4(1,1,1,1);
	vec4 yellow = vec4(1,1,0,1);
	vec4 red = vec4(1,0,0,1);
	vec4 green = vec4(0,1,0,1);
	vec4 blue = vec4(0,0,1,1);
	vec4 orange = vec4(1,0.6,0,1);
	
	vec4 c = vec4(0,0,0,1);
	
	//For all colors do
	for (int i = 0; i < 6; ++i) {
		
		if (gl_PrimitiveIDIn == 0) c = vec4(1,1,1,1);
		else if (gl_PrimitiveIDIn == 1) c = vec4(-1,1,1,1);
		else if (gl_PrimitiveIDIn == 2) c = vec4(-1,-1,1,1);
		else if (gl_PrimitiveIDIn == 3) c = vec4(1,-1,1,1);
		else if (gl_PrimitiveIDIn == 4) c = vec4(1,1,-1,1);
		else if (gl_PrimitiveIDIn == 5) c = vec4(-1,1,-1,1);
		else if (gl_PrimitiveIDIn == 6) c = vec4(-1,-1,-1,1);
		else if (gl_PrimitiveIDIn == 7) c = vec4(1,-1,-1,1);
		else return;
		
		if (gl_PrimitiveIDIn < 4) {
			c = vec4(rotate(c.xyz, vec3(0,0,1), time), 1);
		}
		
		//YELLOW
		if (i == 2) {
			gfrontColor = yellow;
			
			//Paint square
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y+1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y+1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y-1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y-1, c.z+1, 1);
			EmitVertex();
			
			EndPrimitive();
		}
		
		//WHITE
		else if (i == 1) {
			gfrontColor = white;
			
			//Paint square
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y+1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y+1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y-1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y-1, c.z-1, 1);
			EmitVertex();
			
			EndPrimitive();
		}
		
		//RED
		else if (i == 0) {
			gfrontColor = red;
			
			//Paint square
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y+1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y+1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y+1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y+1, c.z+1, 1);
			EmitVertex();
			
			EndPrimitive();
		}
		
		//GREEN
		else if (i == 3) {
			gfrontColor = green;
			
			//Paint square
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y+1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y+1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y-1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y-1, c.z-1, 1);
			EmitVertex();
			
			EndPrimitive();
		}
		
		//BLUE
		else if (i == 4) {
			gfrontColor = blue;
			
			//Paint square
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y+1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y+1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y-1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y-1, c.z-1, 1);
			EmitVertex();
		}
		
		//ORANGE
		else if (i == 5) {
			gfrontColor = orange;
			
			//Paint square
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y-1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y-1, c.z-1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x+1, c.y-1, c.z+1, 1);
			EmitVertex();
			gl_Position = modelViewProjectionMatrix*vec4(c.x-1, c.y-1, c.z+1, 1);
			EmitVertex();
		}
	 }
}

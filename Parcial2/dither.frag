#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in float normalZ;

uniform int mode = 1;

void main()
{
	vec4 white = vec4(1,1,1,1);
	vec4 black = vec4(0,0,0,1);
	 
    if (mode == 1) {
    	if (normalZ < 0.5) fragColor = black;
    	else fragColor = white;
    }
    else if (mode == 2) {
    	float nouLlindar = normalZ;
    
    	if (int(gl_FragCoord.x) % 2 == 0 && int(gl_FragCoord.y) % 2 == 0) nouLlindar -= 0.5;
    	
    	else if (int(gl_FragCoord.x) % 2 == 0 && int(gl_FragCoord.y) % 2 == 1) nouLlindar += 0.25;
    	
    	else if (int(gl_FragCoord.x) % 2 == 1 && int(gl_FragCoord.y) % 2 == 0) nouLlindar += 0;	//Aquesta linea sobra, pero per si de cas ho deixo
    	
    	else if (int(gl_FragCoord.x) % 2 == 1 && int(gl_FragCoord.y) % 2 == 1) nouLlindar -= 0.25;
    	
    	if (nouLlindar < 0.5) fragColor = black;
    	else fragColor = white;
    }
    
}

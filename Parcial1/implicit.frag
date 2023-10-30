#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 fvertex;

uniform int mode = 0;
uniform float eps = 0.05;

float f(vec3 Q)
{
	float x = Q.x*1.65;
	float y = Q.y*1.9;
	float z = Q.z*1.01;
	return 2*y*(y*y-3*x*x)*(1-z*z)+pow(x*x+y*y,2)-(9*z*z-1)*(1-z*z); 
}

void main()
{
    if (mode == 0) fragColor = frontColor;
    
    else if (mode == 1) {
    
    	//S'hauria d'usar la variable que et dona la posició del fragment però no la he trobat :(
    	//Així que he usat el vertex del vertex shader en object space com a placeholder
    	//Sé que està malament
    	float v = f(fvertex);
    	
    	if (v < eps) {
    	    fragColor = vec4(20*v,20*v,20*v,1.0);
    	}
    	else discard;
    }
    
    else if (mode == 2) {
    
    	//Igual que l'apartat anterior, aquí hauria d'anar la posició del fragment en comptes de "fvertex"
    	float v = f(fvertex);
    	
    	float width = dFdx(v) + dFdy(v);
    	
    	if (v < width) fragColor = vec4(0,0,0,1);
    	else discard;
    }
}

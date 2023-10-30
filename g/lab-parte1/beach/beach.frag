#version 330 core

in vec2 vtexCoord;
in vec3 N;
out vec4 fragColor;

uniform sampler2D window;
uniform sampler2D palm1;
uniform sampler2D background2;

uniform float time;

void main()
{
    vec4 colorC = texture(window,vtexCoord);
    
    if(colorC.a==1.0) fragColor = colorC;
    else {
    	vec2 aux = vtexCoord + 0.25*N.xy + vec2(0.1*sin(2*time)*vtexCoord.t,0);
    	vec4 colorD = texture(palm1,aux);
    	
    	if(colorD.a>=0.5) fragColor = colorD;
    	else {
    		fragColor = texture(background2,vtexCoord+0.5*N.xy);
    	}
    }
}

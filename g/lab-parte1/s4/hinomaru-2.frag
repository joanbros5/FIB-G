#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform bool classic = true;

vec4 white = vec4(1);
vec4 red = vec4(1,0,0,1);

const float pi = acos(-1);

void main()
{
    vec2 u = vec2(vtexCoord.x-0.5, vtexCoord.y-0.5);
    float d = length(u);
    float c = step(0.2,d);
    
    if(classic && c>0.0) {
    	float o = atan(u.x, u.y);
    	float c2 = step(mod(o/(pi/16)+0.5, 2), 1);
    	fragColor = vec4(1, vec2(c2), 1);
    }
    else fragColor = vec4(1, vec2(c), 1);
}

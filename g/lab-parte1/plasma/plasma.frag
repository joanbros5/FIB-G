#version 330 core

uniform sampler2D fbm;
uniform float time;
const float pi = 3.14159;

in vec2 vtexCoord;
out vec4 fragColor;

vec4 red = vec4(1,0,0,1);
vec4 yellow = vec4(1,1,0,1);
vec4 green = vec4(0,1,0,1);
vec4 cyan = vec4(0,1,1,1);
vec4 blue = vec4(0,0,1,1);
vec4 magenta = vec4(1,0,1,1);

void main()
{
    float r = texture(fbm,vtexCoord).r;
    float A = 1;
    float f = 0.1;
    float alpha = 2*pi*r;
    float v = A*sin(2*pi*f*time + alpha);
    
    v = 3*(v+1);
    
    if(v<0) fragColor = red;
    else if(v<1) fragColor = mix(red,yellow,fract(v));
    else if(v<2) fragColor = mix(yellow,green,fract(v));
    else if(v<3) fragColor = mix(green,cyan,fract(v));
    else if(v<4) fragColor = mix(cyan,blue,fract(v));
    else if(v<5) fragColor = mix(blue,magenta,fract(v));
    else if(v<6) fragColor = mix(magenta,red,fract(v));
    else fragColor = red;
}

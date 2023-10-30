#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

vec4 white= vec4(1,1,1,1);
vec4 black = vec4(0,0,0,1);
vec4 grey = vec4(0.8,0.8,0.8,0.8);
vec4 skin = vec4(1,0.8,0.6,1);

uniform int mode = 2;

void detail0() {
    float d = length(vec2(vtexCoord.x-0.8,vtexCoord.y-0.8));
    if(d <=0.2) fragColor = black;

    d = length(vec2(vtexCoord.x-0.2,vtexCoord.y-0.8));
    if(d <=0.2) fragColor = black;

    d = length(vec2(vtexCoord.x-0.5,vtexCoord.y-0.4));
    if(d <=0.35) fragColor = black;
}

void detail1() {
     //EYES
     vec2 texCoord = vtexCoord;
     texCoord.x *= 1.5;
     float d = length(vec2(texCoord.x-0.65,texCoord.y-0.5));
     if(d<=0.2) fragColor = skin;

     d = length(vec2(texCoord.x-0.85,texCoord.y-0.5));
     if(d<=0.2) fragColor = skin;

     //MOUTH
     texCoord = vtexCoord;
     texCoord.x /= 2;
     d = length(vec2(texCoord.x-0.25,texCoord.y-0.3));
     if(d<=0.15) fragColor = skin;
}

void detail2() {
     //EYES
     vec2 texCoord = vtexCoord;
     texCoord.x *= 2;
     float d = length(vec2(texCoord.x-0.9,texCoord.y-0.5));
     if(d<=0.15) fragColor = white;

     d = length(vec2(texCoord.x-1.1,texCoord.y-0.5));
     if(d<=0.15) fragColor = white;

     //IRIS
     texCoord = vtexCoord;
     texCoord.x *= 2;
     d = length(vec2(texCoord.x-0.9,texCoord.y-0.475));
     if(d<=0.08) fragColor = black;

     d = length(vec2(texCoord.x-1.1,texCoord.y-0.475));
     if(d<=0.08) fragColor = black;
}

void main()
{
    fragColor = grey;
    
    detail0();
    if(mode>0) detail1();
    if(mode>1) detail2(); 
}

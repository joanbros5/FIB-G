#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;

uniform sampler2D explosion;

uniform float time;

void main()
{
    float slice = 1.0/5;
    int frame = int(mod(time/slice, 48));
    int x = frame%8;
    int y = 6 - frame/8;
    
    vec2 texCoord = vtexCoord*vec2(1.0/8, 1.0/6);
    texCoord.x += x/8.0;
    texCoord.y += y/6.0;
    
    
    fragColor = texture(explosion, texCoord);
    fragColor = fragColor * fragColor.w;
}

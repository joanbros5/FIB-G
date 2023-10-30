#version 330 core

uniform sampler2D colorMap;

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

void main()
{
    
    //SETEJAR EL GRID (5*5)
    vec2 coord = vtexCoord * 5;
    
    //QUEDAR-SE LA PART FRACCIONARIA DE LES COORDENADES
    coord = fract(coord);

    //ESCOLLIR TEXTURA (original és 6*1)
    fragColor = texture(colorMap, vec2(0.0/6.0 + coord.x/6.0, coord.y));
}

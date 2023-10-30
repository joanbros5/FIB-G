#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

in vec3 normalModel[];

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

vec4 punts[] = vec4[](
    vec4(-.1, 0., 0., 1.),
    vec4(0.1, 0., 0., 1.),
    vec4(-.1, 1., 0.01, 1.),
    vec4(0.1, 1., 0., 1.),
    vec4(-.09, 1.8, 0.01, 1.),
    vec4(.1, 1.8, 0., 1.),
    vec4(-0.08, 2.5, 0.01, 1.),
    vec4(0.085, 2.5, 0.01, 1.),
    vec4(-0.06, 3.2, 0.018, 1.),
    vec4(0.075, 3.2, 0.012, 1.),
    vec4(-0.045, 4, 0.2, 1.),
    vec4(0.075, 4, 0.016, 1.),
    vec4(-0.035, 4.5, 0.23, 1.),
    vec4(0.074, 4.5, 0.018, 1.),
    vec4(-0.02, 5, 0.25, 1.),
    vec4(0.072, 5, 0.02, 1.),
    vec4(0.01, 6, 0.26, 1.),
    vec4(0.05, 6, 0.22, 1.),
    vec4(0.03, 7, 0.26, 1.)
);

void blade(mat4 trf) {
    gfrontColor = vec4(0.02,0.8, 0.0, 1.0);
    for (int i=0; i<punts.length(); ++i) {
        gl_Position = trf * punts[i];
        EmitVertex();
    }
    EndPrimitive();
}

void main( void )
{
	float diametre = distance(boundingBoxMin, boundingBoxMax);
	float factorD = diametre / 80;
     
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
    
    for (int j = 0; j < 3; j++) {
		//Matriu d'escalat
		mat4 scale = mat4(factorD, 0.0, 0.0, 0.0,
						  0.0, factorD, 0.0, 0.0,
						  0.0, 0.0, factorD, 0.0,
						  0.0, 0.0, 0.0, 1.0);
		
		//Calcular components de trf:
		
		//Normal
		vec3 N = normalModel[j];
		
		//Baricentre de la cara (necessito 3 vertexs?)
		//Està malament
		vec3 C = N;
		
		//Vectors unitaris de X i Z
		vec3 cx, cz;
		if (N == vec3(0,0,1) || N == vec3(0,0,-1)) {
			cx = vec3(1,0,0);
			cz = vec3(0,0,1);
		}
		else {
			cx = normalize(N*vec3(0,0,1));
			cz = normalize(cx*N);
		}
		
		//Construir trf
		mat4 trf = mat4(cx.x, N.x, cz.x, C.x,
						cx.y, N.y, cz.y, C.y,
						cx.z, N.z, cz.z, C.z,
						0.0 , 0.0, 0.0 , 1.0);

		//trf * scale -> primer escalat i després rotat i trasllat
		blade(trf*scale);
	}
}

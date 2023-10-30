#include "modelInfo1.h"
#include "glwidget.h"

void ModelInfo1::printModelInfo() {
	Scene* scn = scene();
	int nObj = scn->objects().size();
	int nPol = 0;
	int nVer = 0;
	int nTri = 0;
	
	for(int i=0; i<nObj; ++i) {
		const Object& obj = scn->objects()[i];
		int nfaces = obj.faces().size();
		nPol += nfaces;
		
		for(int j=0; j<nfaces; ++j) {
			const Face& face = obj.faces()[j];
			nVer += face.numVertices();
			if(face.numVertices()%3 == 0) ++nTri;
		}
	}
	
	cout << "INFO:" << endl;
	cout << " - Num objetos: " << nObj << endl;
	cout << " - Num poligonos: " << nPol << endl;
	cout << " - Num vertices: " << nVer << endl;
	cout << " - Num triangulos: " << nTri << endl;
	
	if(nPol!=0) cout << " - Porcentaje de triangulos: " << double(nTri/nPol)*100 << "%" << endl;
	else cout << " - Porcentaje de triangulos: NULL" << endl;
}

void ModelInfo1::onPluginLoad()
{
	printModelInfo();
}

void ModelInfo1::onObjectAdd()
{
	printModelInfo();
}

void ModelInfo1::onObjectLoad()
{
	printModelInfo();
}

void ModelInfo1::onSceneClear()
{
	printModelInfo();
}

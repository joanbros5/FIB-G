#include "showDegree.h"
#include "glwidget.h"

void ShowDegree::onPluginLoad()
{
	const Object &obj = scene()->objects()[0];
	const int nFaces = obj.faces().size();
	const int nVertexFaces = nFaces*3;
	const int nVertex = obj.vertices().size();
	
	gradoMedio = double(nVertexFaces)/nVertex;
}

void ShowDegree::postFrame()
{
	painter.begin(glwidget());
	QFont font;
	font.setPixelSize(15);
	painter.setFont(font);
	
	painter.drawText(5,20,QString("%1").arg(gradoMedio));
	painter.end();
}

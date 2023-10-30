#ifndef _DRAWBOUNDINGBOX_H
#define _DRAWBOUNDINGBOX_H

#include "plugin.h" 
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>

class DrawBoundingBox: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	 void onPluginLoad();
	 void postFrame();
	 
  private:
	// add private methods and attributes here
	QOpenGLShaderProgram* program;
	QOpenGLShader *fs;
	QOpenGLShader *vs;
	
	bool created;
	GLuint cubeVAO;
	GLuint vertexVBO;
	GLuint colorVBO;
};

#endif

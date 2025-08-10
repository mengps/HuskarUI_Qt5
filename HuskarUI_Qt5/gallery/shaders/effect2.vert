#version 450

layout(location = 0) in vec4 qt_Vertex;
layout(location = 1) in vec2 qt_MultiTexCoord0;
layout(location = 0) out vec2 fragCoord;

uniform mat4 qt_Matrix;
uniform float qt_Opacity;

void main()
{
    fragCoord = vec2(qt_Vertex);
    gl_Position = qt_Matrix * qt_Vertex;
}

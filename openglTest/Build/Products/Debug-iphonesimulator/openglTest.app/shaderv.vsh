attribute vec4 position;
attribute vec4 aColor;
attribute vec2 aTexCoord;
uniform mat4 transform;
uniform mat4 modelMat;
uniform mat4 viewMat;
uniform mat4 projectionMat;
varying vec4 outColor;
varying vec2 TexCoord;
void main()
{
    gl_Position = projectionMat*viewMat*modelMat*position;
    outColor = aColor;
    TexCoord = vec2(aTexCoord.x,aTexCoord.y);
}

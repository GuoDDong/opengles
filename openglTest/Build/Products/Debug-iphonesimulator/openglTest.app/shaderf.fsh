precision mediump float;
varying vec4 outColor;
varying vec2 TexCoord;
uniform sampler2D ourTexture;
void main()
{
    gl_FragColor = outColor;
}

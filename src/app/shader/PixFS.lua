return [[
#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform float u_pixelSize;

void main()
{
    vec2 pixelatedUV = floor(v_texCoord / u_pixelSize) * u_pixelSize;
    gl_FragColor = texture2D(u_texture, pixelatedUV);
}
]]
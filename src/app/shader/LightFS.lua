return [[
#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform float u_brightness;

void main()
{
    vec4 color = texture2D(u_texture, v_texCoord);
    gl_FragColor = vec4(color.rgb * u_brightness, color.a);
}

]]
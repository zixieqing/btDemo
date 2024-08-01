return [[
#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform float u_time;

void main()
{
    vec2 uv = v_texCoord;
    uv.y += sin(uv.x * 10.0 + u_time) * 0.05; // 波动效果
    gl_FragColor = texture2D(u_texture, uv);
}

]]
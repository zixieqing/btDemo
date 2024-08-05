return [[
#ifdef GL_ES
precision mediump float;
#endif


varying vec2 v_texCoord;

uniform sampler2D u_Texture;
uniform vec3 u_OriginalColor; // 要替换的颜色
uniform vec3 u_TargetColor;   // 目标颜色

void main()
{
    vec4 src_color = texture2D(u_Texture, v_texCoord); // 获取原始纹理颜色

    vec4 cc_FragColor = vec4(1.0, 1.0, 1.0, 1.0); // 设置为白色

    // 检查当前像素与原始颜色的相似度
    float threshold = 0.2; // 颜色相似度阈值
    if (abs(src_color.r - u_OriginalColor.r) < threshold &&
        abs(src_color.g - u_OriginalColor.g) < threshold &&
        abs(src_color.b - u_OriginalColor.b) < threshold) {
        src_color.rgb = u_TargetColor; // 替换为目标颜色
    }
    
    gl_FragColor = src_color; // 结合顶点颜色
}

]]
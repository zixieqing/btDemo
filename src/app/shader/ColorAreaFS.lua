--- 设置精灵某个区域颜色值
return [[
#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
uniform sampler2D u_texture; // 使用新的纹理变量
uniform vec2 u_areaPosition;
uniform vec2 u_areaSize;
uniform vec4 u_customColor;   // 自定义颜色

void main(void)
{
    vec4 src_color = texture2D(u_texture, v_texCoord).rgba; // 读取原始颜色

    // 判断当前像素是否在指定区域内
    if (v_texCoord.x >= u_areaPosition.x && v_texCoord.x <= u_areaPosition.x + u_areaSize.x &&
        v_texCoord.y >= u_areaPosition.y && v_texCoord.y <= u_areaPosition.y + u_areaSize.y &&
        src_color.a > 0.0)
    {
        // 在指定区域内，将颜色修改为红色
        gl_FragColor = vec4(0.0, 1.0, 0.0, src_color.a); // 红色，保持透明度
        // 混合原始颜色与自定义颜色
        //gl_FragColor = mix(src_color, u_customColor, 0.5); // 50% 混合
        //gl_FragColor = vec4(u_customColor.r, u_customColor.g, u_customColor.b, 1.0);
    }
    else
    {
        // 否则，保持原有颜色
        gl_FragColor = src_color;
    }
}


]]


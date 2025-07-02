--
-- Author: xianwx
-- Date: 2018-08-21 17:20:05
--
return [[
    #ifdef GL_ES
    precision mediump float;
    #endif
    uniform vec2 resolution;
    uniform vec2 mouse;
    varying vec2 v_texCoord;

    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        // y坐标翻转
        vec2 imouse = vec2(mouse.x, resolution.y - mouse.y);
        // 纹理坐标
        vec2 uv = v_texCoord.xy ;
        // 纹理采样
        vec4 tex = texture2D(CC_Texture0, uv);
        // 片元到鼠标点的差向量
        vec2 d = uv*resolution.xy -imouse.xy ;
        // 光照半径
        vec2 s = 0.15 * resolution.xy;
        // 点积取比例
        float r = dot(d, d)/dot(s,s);
        //fragColor =  tex * (1.5 - r);
        float opacity = 0.02;

         // 计算最终颜色
        if (r < 1.0) {
            // 在光圈内，显示正常纹理颜色
            fragColor = tex * (1.1- r);
            //fragColor = tex * (1.08 - r) * opacity + tex * (1.0 - opacity);
        } else {
            // 在光圈外，设置为透明度
            fragColor = vec4(tex.rgb, tex.a * opacity); // 根据透明度调整
        }
        //fragColor = tex * (1.08 - r) * opacity + tex * (1.0 - opacity);
    }
    void main()
    {
        mainImage(gl_FragColor, gl_FragCoord.xy);
    }
]]

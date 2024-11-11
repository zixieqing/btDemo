--- hsv
return [[
#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
uniform vec3 dest_color;      

// 将 RGB 转换为 HSV
vec3 rgbToHsv(vec3 rgb) {
    float maxC = max(max(rgb.r, rgb.g), rgb.b);
    float minC = min(min(rgb.r, rgb.g), rgb.b);
    float delta = maxC - minC;

    float h = 0.0;
    if (delta > 0.0) {
        if (maxC == rgb.r) {
            h = mod((rgb.g - rgb.b) / delta, 6.0);
        } else if (maxC == rgb.g) {
            h = (rgb.b - rgb.r) / delta + 2.0;
        } else {
            h = (rgb.r - rgb.g) / delta + 4.0;
        }
        h /= 6.0;
    }

    float s = (maxC == 0.0) ? 0.0 : delta / maxC;
    float v = maxC;

    return vec3(h, s, v);
}

// 将 HSV 转换为 RGB
vec3 hsvToRgb(vec3 hsv) {
    float h = hsv.x * 6.0;
    float c = hsv.y * hsv.z;
    float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
    float m = hsv.z - c;

    vec3 rgb;
    if (h < 1.0) {
        rgb = vec3(c, x, 0.0);
    } else if (h < 2.0) {
        rgb = vec3(x, c, 0.0);
    } else if (h < 3.0) {
        rgb = vec3(0.0, c, x);
    } else if (h < 4.0) {
        rgb = vec3(0.0, x, c);
    } else if (h < 5.0) {
        rgb = vec3(x, 0.0, c);
    } else {
        rgb = vec3(c, 0.0, x);
    }

    return rgb + vec3(m);
}


void main(void)
{
    vec4 src_color = texture2D(CC_Texture0, v_texCoord).rgba; // 读取原始颜色

    // 判断当前像素是否在指定区域内
    if (src_color.b > 0 && src_color.r == 0 && src_color.g == 0)
    {
        //src_color.rgb = u_customColor; // 替换为目标颜色


        // 将 RGB 转换为 HSV
        vec3 hsv = rgbToHsv(src_color.rgb);

        vec3 destHsv = rgbToHsv(dest_color.rgb);
        
        // 修改 HSV 值，例如：增加色相
        hsv.x += destHsv.x; // 修改色相
        hsv.y *= destHsv.y; // 修改饱和度
        hsv.z *= destHsv.z; // 修改明度

        // 保证 HSV 值在合理范围内
        hsv.x = mod(hsv.x, 1.0);
        hsv.y = clamp(hsv.y, 0.0, 1.0);
        hsv.z = clamp(hsv.z, 0.0, 1.0);

        // 将修改后的 HSV 转换回 RGB
        vec3 newColor = hsvToRgb(hsv);
        src_color.rgb = newColor;
        //gl_FragColor = vec4(newColor, src_color.a); // 保留 alpha 通道
    }
    gl_FragColor = src_color; 
}


]]


return [[
 #ifdef GL_ES
    precision mediump float;
    #endif
    
    varying vec2 v_texCoord;
    uniform vec3 dest_color_b;




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

// 修改颜色的色相
vec3 modifyHue2(vec3 color, vec3 targetColor) {
    // 将颜色转换为 HSV
    vec3 hsvColor = rgbToHsv(color);
    vec3 hsvTarget = rgbToHsv(targetColor);

    // 计算色相差值
    float hueDifference = hsvTarget.x - hsvColor.x;

    // 修改色相
    hsvColor.x = mod(hsvColor.x + hueDifference, 1.0);

    // 将修改后的 HSV 转换回 RGB
    return hsvToRgb(hsvColor);
}

vec3 modifyHue(vec3 color, vec3 targetColor) {
    // 将颜色转换为 HSV
    vec3 hsvColor = rgbToHsv(color);
    vec3 hsvTarget = rgbToHsv(targetColor);

    // 检查饱和度
    

    // 计算色相差值
    float hueDifference = hsvTarget.x - hsvColor.x;

    // 修改色相
    hsvColor.x = mod(hsvColor.x + hueDifference, 1.0);



    // 将修改后的 HSV 转换回 RGB
    return hsvToRgb(hsvColor);
}


void main(void) {
    vec4 src_color = texture2D(CC_Texture0, v_texCoord).rgba; 
   
    vec3 targetColor = dest_color_b; 
    if (length(dest_color_b) > 0.0 && src_color.b > 0 && src_color.r == 0 && src_color.g == 0)
    {
        src_color.a = src_color.b;
        src_color.rgb = modifyHue(src_color, targetColor);
    }
    gl_FragColor = src_color; 
}

]]
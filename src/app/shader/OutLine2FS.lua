return [[
precision mediump float;
uniform sampler2D u_texture;
uniform vec2 u_sprite_size; // 纹理高度
varying vec2 v_texCoord;

void main() {
    vec4 color = texture2D(u_texture, v_texCoord);
    
    // 如果当前像素是透明的，直接返回透明
    if (color.a < 0.1) {
       // gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // 完全透明
        return;
    }
    
    float pixelWidth = 1.0 / u_sprite_size.x;
    float pixelHeight = 1.0 / u_sprite_size.y;
    
    float alphaSum = 0.0;

    // 检查周围像素的透明度
    for (float x = -1.0; x <= 1.0; x += 1.0) {
        for (float y = -1.0; y <= 1.0; y += 1.0) {
            if (x == 0.0 && y == 0.0) continue; // 跳过当前像素
            
            // 计算周围像素的纹理坐标
            vec2 offset = vec2(x * pixelWidth, y * pixelHeight);
            vec4 neighborColor = texture2D(u_texture, v_texCoord + offset);
            alphaSum += neighborColor.a;
        }
    }

    // 根据周围像素的透明度设置颜色
    if (alphaSum > 6.0) {
        gl_FragColor = color; 
    } else {
        gl_FragColor = vec4(0.0,1.0,0.0,1.0);
    }
}

]]
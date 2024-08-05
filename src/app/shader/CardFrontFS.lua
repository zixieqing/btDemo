return [[
uniform int type;           // 添加类型的 uniform 声明
uniform float val;          // 添加值的 uniform 声明
varying vec2 v_uv0;         // 添加纹理坐标的 varying 声明

void main () {
    vec4 o = vec4(1, 1, 1, 1);
    vec4 shadow_color = vec4(0.7, 0.7, 0.7, 1.0);
    
    #if USE_TEXTURE
      CCTexture(texture, v_uv0, o);
    #endif

    bool hidden = false;
    bool shadow = false;

    // 显示右下
    if (type == 1) {
        if (v_uv0.x + v_uv0.y > 1.0 - val) {
            hidden = true;
        }
    }

    // 显示左下
    if (type == 2) {
        if ((v_uv0.x + v_uv0.y) > 1.0 && (v_uv0.y + val) > v_uv0.x) {
            hidden = true;
        }
        if ((v_uv0.x + v_uv0.y) < 1.0 && (v_uv0.y + val) > v_uv0.x) {
            hidden = true;
        }
    }

    // 显示右上
    if (type == 3) {
        if ((v_uv0.x + v_uv0.y) < 1.0 && (v_uv0.x + val) > v_uv0.y) {
            hidden = true;
        }
        if ((v_uv0.x + v_uv0.y) > 1.0 && (v_uv0.x + val) > v_uv0.y) {
            hidden = true;
        }
        
        if ((v_uv0.x + v_uv0.y) < 1.0 && (v_uv0.x + val) > v_uv0.y - 0.02) {
            shadow = true;
        }
        if ((v_uv0.x + v_uv0.y) > 1.0 && (v_uv0.x + val) > v_uv0.y - 0.02) {
            shadow = true;
        }
    }

    // 显示左上
    if (type == 4) {
        if (v_uv0.x + v_uv0.y < 1.0 + val) {
            hidden = true;
        }
    }

    // 剔除隐藏像素
    if (hidden) {
        o.a = 0.0;
    }

    // 增加阴影
    if (shadow) {
        // o *= shadow_color; // 可以取消注释以应用阴影
    }

    //ALPHA_TEST(o);

    #if USE_BGRA
      gl_FragColor = o.bgra;
    #else
      gl_FragColor = o.rgba;
    #endif
}
]]

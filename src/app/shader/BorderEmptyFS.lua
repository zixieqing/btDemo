-- return [[
-- #ifdef GL_ES
-- precision mediump float;
-- #endif

-- varying vec4 cc_FragColor;
-- varying vec2 cc_FragTexCoord1;
-- uniform vec4 a_color;

-- uniform sampler2D u_texture;

-- const int SAMPLES = 19;
-- varying vec2 v_OutlineSamples[SAMPLES];

-- void main() {
--     // 获取当前纹理颜色
--     vec4 textureColor = texture2D(u_texture, cc_FragTexCoord1);
    
--     // 计算边缘 alpha
--     float edgeAlpha = 0.0;
--     for (int i = 0; i < SAMPLES; i++) {
--         vec4 sampleColor = texture2D(u_texture, v_OutlineSamples[i]);
--         if (sampleColor.a > 0.0) {
--             edgeAlpha = max(edgeAlpha, sampleColor.a); // 计算边缘的 alpha
--         }
--     }

--     // 设置边缘颜色为金黄色
--     vec4 outlineColor = vec4(1.0, 0.84, 0.0, edgeAlpha);

--     // 只有在透明色与颜色交汇处显示金黄色
--     if (textureColor.a == 0.0 && edgeAlpha > 0.0) {
--         gl_FragColor = outlineColor; // 边缘部分显示金黄色
--     } else if (textureColor.a > 0.0) {
--         gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // 显示原始纹理颜色
--     } else {
--         gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // 透明部分
--     }
-- }

-- ]]



--非镂空
-- return [[
-- #ifdef GL_ES
-- precision mediump float;
-- #endif

-- varying vec4 cc_FragColor;
-- varying vec2 cc_FragTexCoord1;
-- uniform vec4 a_color;

-- uniform sampler2D u_texture;

-- const int SAMPLES = 6;
-- varying vec2 v_OutlineSamples[SAMPLES];

-- vec4 composite(vec4 over, vec4 under) {
--     // 计算边缘的 alpha
--     float edgeAlpha = over.a > 0.0 ? 1.0 : 0.0; // 如果有颜色，则边缘完全不透明
--     return vec4(over.rgb, edgeAlpha) + (1.0 - edgeAlpha) * under;
-- }

-- void main() {
--     // 使用 v_OutlineSamples[] 数组中的坐标
--     float outlineAlpha = 0.0;
--     for (int i = 0; i < SAMPLES; i++) {
--         float alpha = texture2D(u_texture, v_OutlineSamples[i]).a;
--         outlineAlpha = max(outlineAlpha, alpha); // 使用 max 计算轮廓的 alpha
--     }
    
--     vec4 outlineColor = vec4(1.0, 0.84, 0.0, outlineAlpha); // 金黄色边缘
--     vec4 textureColor = texture2D(u_texture, cc_FragTexCoord1); // 获取纹理颜色
    
--     // 计算最终颜色
--     if (textureColor.a > 0.0) {
--         gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // 中间部分透明
--     } else {
--         gl_FragColor = outlineColor; // 边缘部分显示金黄色
--     }
-- }

-- ]]


--- 更细的边缘线
return [[
#ifdef GL_ES
precision mediump float;
#endif

varying vec4 cc_FragColor;
varying vec2 cc_FragTexCoord1;
uniform vec4 a_color;

uniform sampler2D u_texture;

const int SAMPLES = 19;
varying vec2 v_OutlineSamples[SAMPLES];

void main() {
    // 获取当前纹理颜色
    vec4 textureColor = texture2D(u_texture, cc_FragTexCoord1);
    
    // 计算边缘 alpha
    float edgeAlpha = 0.0;
    for (int i = 0; i < SAMPLES; i++) {
        vec4 sampleColor = texture2D(u_texture, v_OutlineSamples[i]);
        if (sampleColor.a > 0.0) {
            edgeAlpha = max(edgeAlpha, sampleColor.a); // 计算边缘的 alpha
        }
    }

    // 通过缩小边缘 alpha 的影响来实现更细的边缘
    edgeAlpha *= 0.01; // 调整这一行以控制边缘的细度

    // 设置边缘颜色为金黄色
    vec4 outlineColor = vec4(1.0, 0.84, 0.0, edgeAlpha);

    // 只有在透明色与颜色交汇处显示金黄色
    if (textureColor.a == 0.0 && edgeAlpha > 0.0) {
        gl_FragColor = outlineColor; // 边缘部分显示金黄色
    } else if (textureColor.a > 0.0) {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // 显示原始纹理颜色
    } else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // 透明部分
    }
}

]]

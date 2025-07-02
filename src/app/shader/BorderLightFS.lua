
return [[
#ifdef GL_ES
precision mediump float;
#endif

varying vec4 cc_FragColor;
varying vec2 cc_FragTexCoord1;

//uniform sampler2D u_texture;
uniform vec3 u_color;
uniform float u_flash; // 控制闪烁的变量
uniform int u_isFlashing; // 使用整数控制是否闪烁的变量

const int SAMPLES = 31;
varying vec2 v_OutlineSamples[SAMPLES];

void main() {
    // 获取当前纹理颜色
    vec4 textureColor = texture2D(CC_Texture0, cc_FragTexCoord1);
    
    // 计算边缘 alpha
    float edgeAlpha = 0.0;
    for (int i = 0; i < SAMPLES; i++) {
        vec4 sampleColor = texture2D(CC_Texture0, v_OutlineSamples[i]);
        if (sampleColor.a > 0.0) {
            edgeAlpha = max(edgeAlpha, sampleColor.a); // 计算边缘的 alpha
        }
    }

    // 设置边缘颜色为金黄色
    vec4 outlineColor = vec4(u_color.r, u_color.g, u_color.b, edgeAlpha);

    // 计算闪烁颜色
    //vec4 flashColor = mix(vec4(1.0, 1.0, 1.0, 1.0), vec4(0.0, 0.0, 1.0, 1.0), (sin(u_flash * 3.14) + 1.0) / 2.0); // 由白色到蓝色的渐变

    //if(u_isFlashing==1){
      //  outlineColor = flashColor;
    //}
    // 只有在透明色与颜色交汇处显示金黄色
    if (textureColor.a == 0.0 && edgeAlpha > 0.0) {
        gl_FragColor = outlineColor; // 边缘部分显示金黄色
    } else if (textureColor.a > 0.0) {
        gl_FragColor = textureColor; // 显示原始纹理颜色
    } else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // 透明部分
    }
    // 合成纹理颜色和轮廓颜色
   // gl_FragColor = composite(textureColor, outlineColor);
}
]]

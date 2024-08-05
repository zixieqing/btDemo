return [[
#ifdef GL_ES
precision mediump float;
#endif

varying vec4 cc_FragColor;
varying vec2 cc_FragTexCoord1;
uniform vec4 u_outlineColor;

uniform sampler2D u_texture;

const int SAMPLES = 6;
varying vec2 v_OutlineSamples[SAMPLES];

vec4 composite(vec4 over, vec4 under) {
    return over + (1.0 - over.a) * under;
}

void main() {
    // 使用 v_OutlineSamples[] 数组中的坐标
    float outlineAlpha = 0;
    for (int i = 0; i < SAMPLES; i++) {
        float alpha = texture2D(u_texture, v_OutlineSamples[i]).a;
       outlineAlpha = max(outlineAlpha, alpha); // 使用 max 计算轮廓的 alpha
        //outlineAlpha = outlineAlpha + (1.0 - outlineAlpha)*alpha;
    }
    vec4 a_color = vec4(1.0, 0.84, 0.0, 1.0); // 金黄色，完全不透明    
    vec4 outlineColor = a_color*outlineAlpha;
    vec4 textureColor = texture2D(u_texture, cc_FragTexCoord1);
    
    // 合成纹理颜色和轮廓颜色
    gl_FragColor = composite(textureColor, outlineColor);
}



]]
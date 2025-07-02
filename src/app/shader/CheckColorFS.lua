return [[
precision mediump float;
uniform sampler2D u_texture;
uniform vec2 u_sprite_size; // 纹理高度
varying vec2 v_texCoord;

void main() {
    vec4 color = texture2D(u_texture, v_texCoord);
    
    // 检查纹理坐标是否在安全区内
    if (v_texCoord.x >= safeArea.x && v_texCoord.x <= safeArea.x + safeArea.z &&
        v_texCoord.y >= safeArea.y && v_texCoord.y <= safeArea.y + safeArea.w) {
        // 在安全区内，变色为绿色
        color = vec4(0.0, 1.0, 0.0, color.a);
    }
    gl_FragColor = color;
}

]]
return [[
precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_holeCenter; // 挖洞中心
uniform float u_holeRadius; // 挖洞半径
uniform vec2  u_spriteSize;
void main()
{
    vec4 color = texture2D(u_texture, v_texCoord);
    
    // 计算当前像素到挖洞中心的距离
    //float dist = distance(v_texCoord, u_holeCenter);
    

    vec2 normalizedCoord = (v_texCoord - u_holeCenter) * u_spriteSize / min(u_spriteSize.x, u_spriteSize.y);
    float dist = length(normalizedCoord);
    
    // 如果在挖洞范围内，返回透明色
    if (dist < u_holeRadius) {
        discard; // 丢弃该片段     
    }
    
    gl_FragColor = color; // 否则显示原始颜色
}

]]
return [[
    #ifdef GL_ES
    precision lowp float;
    #endif

    uniform float time;

    varying vec4 v_fragmentColor;
    varying vec2 v_texCoord;
    void main()
    {
        vec4 c = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
        gl_FragColor = c;

        float temp = v_texCoord.x - time;
        if (temp <= 0.0) {
            float temp2 = abs(temp);
            if (temp2 <= 0.2) {
                gl_FragColor.w = 1.0 - temp2/0.2;
            } else {
                gl_FragColor.w = 0.0;
            }
        } else {
            gl_FragColor.w = 1.0;
        }
    }
]]

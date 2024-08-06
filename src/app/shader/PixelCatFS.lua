return [[
#ifdef GL_ES                                 
precision lowp float;                          
#endif  


float nrand(float x, float y){
  return fract(sin(dot(vec2(x, y), vec2(12.9898, 78.233))) * 43758.5453);
}

const float rows_cnt = 64.0;
const float jitter_power = 0.02;
const float jitter_ratio = 0.9;
const float shake_power = 0.02;
const float drift_power = 0.04;
const float period = 3.0;
const vec2 block1_cnt = vec2(4, 4);
const vec2 block2_cnt = vec2(7, 7);
const float block_threshold = 6.0;
const float block_refresh_time = 0.05;

uniform vec2 iResolution;
uniform float iTime;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    float phase = mod(iTime, period) / period;
    float time_factor = smoothstep(0.0, 0.5, phase) - smoothstep(0.5, 1.0, phase);
    
    float jitter = nrand(floor(uv.y * rows_cnt) / rows_cnt, iTime) * 2.0 - 1.0;
    jitter *= step(1.0 - jitter_ratio * time_factor, abs(jitter)) * jitter_power * time_factor;
    float shake = (nrand(0.114, iTime) - 0.5) * shake_power * time_factor;
    float drift = nrand(nrand(floor(uv.x * rows_cnt), floor(uv.y * rows_cnt)), iTime) * drift_power * time_factor;
    
    float block1 = nrand(floor(iTime / block_refresh_time) + 0.514, 
          nrand(floor(uv.x * block1_cnt.x), floor(uv.y * block1_cnt.y)));
    float block2 = nrand(floor(iTime / block_refresh_time) + 0.514, 
          nrand(floor(uv.x * block2_cnt.x), floor(uv.y * block2_cnt.y)));
    float block = pow(block1 * block2, block_threshold) * time_factor;
    
    vec2 texuv1 = fract(vec2(uv.x + jitter + shake + drift, uv.y));
    vec2 texuv2 = fract(vec2(uv.x + jitter + shake + block, uv.y));
    vec2 texuv3 = fract(vec2(uv.x + jitter + shake - block, uv.y));
    
    float colorR = texture(iChannel0, texuv1).r;
    float colorG = mix(texture(iChannel0, texuv2).g, texture(iChannel1, uv).g, block);
    float colorB = mix(texture(iChannel0, texuv3).b, texture(iChannel1, uv).b, block);

    fragColor = vec4(colorR, colorG, colorB, 1);
    // fragColor = vec4(1, 1, 1, 1) * block;

}
void main()
{
mainImage(gl_FragColor, gl_FragCoord.xy);
}
]]
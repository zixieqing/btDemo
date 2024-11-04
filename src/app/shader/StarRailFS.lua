return [[
uniform sampler2D diffuse;
uniform vec2 resolution;
uniform float progress;  
uniform vec2 center;    //光圈中心点
uniform vec3 highlight; //光圈的颜色
		
#define FXAA_REDUCE_MIN   (1.0/128.0)
#define FXAA_REDUCE_MUL   (1.0/8.0)
#define FXAA_SPAN_MAX     8.0



void main() {
	vec2 uv = gl_FragCoord.xy  / resolution; //归一化为[0,1]
   // vec2 uv = vec2(gl_FragCoord.x / resolution.x, 1.0 - gl_FragCoord.y / resolution.y); // 归一化为[0,1]并翻转y轴

    //vec2 scale = vec2(0.5, 1); //宽高比的缩放因子
	vec2 scale = vec2(1.,resolution.y/resolution.x); //宽高比的缩放因子
 
    vec2 uv2 = (uv - .5)*scale+.5; //这个转换的目的是将坐标的中心点移动到原点，以便进行缩放操作。


  float dist = distance(uv ,center);



  vec4 color = texture2D(diffuse,uv);
  //vec4 color2 = color;
  
  if(dist<= progress+.2&&dist>=progress-.2){
    
    float diff = dist - progress; 

    float scaleDiff = (1.0 - pow(abs(diff * 5.), 0.4)); 

    float diffTime = diff * scaleDiff;

    vec2 diffUv = (normalize(uv - center)-.5)*scale+.5;

    uv += ((diffUv * diffTime) / (progress * dist * 10.0))*smoothstep(0.0,.15,dist);
  

    color = texture2D(diffuse, uv);

    color.rgb += (highlight * scaleDiff) / (progress * dist * 10.0);
  }

  gl_FragColor = color;
	gl_FragColor.rgb = mix(vec3(0.), gl_FragColor.rgb , smoothstep(.1,.4,progress));
}

]]
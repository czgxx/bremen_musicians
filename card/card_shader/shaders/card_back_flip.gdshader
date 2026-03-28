shader_type canvas_item;
render_mode unshaded;
uniform bool enable=false;
uniform vec2 card_size=vec2(32.,48.);
uniform float time:hint_range(0.0, 1.0, 0.01)=0.3;
uniform float speed:hint_range(0.0, 1.0, 0.01)=1.0;
group_uniforms group_texture;


// 屏幕纹理
uniform sampler2D screen_texture:hint_screen_texture,filter_nearest;

// 卡面前备缓冲区
uniform sampler2D card_front : repeat_disable, filter_nearest;
// 卡背后备缓冲区
uniform sampler2D card_back : repeat_disable, filter_nearest;

//// 正面纹理
//uniform sampler2D card_front:filter_nearest;
//// 背面纹理
//uniform sampler2D card_back:filter_nearest;
group_uniforms;
void vertex() {
	//VERTEX=vec2(10,20)+VERTEX;
	// Called for every vertex the material is visible on.
}

void fragment() {
	
    vec2 uv = UV;
	vec4 final_color;
	vec4 color_screen=texture(screen_texture,SCREEN_UV);
	vec4 color_card_back=texture(card_back,uv);
	vec4 color_card_front=texture(card_front,uv);
	vec4 color_card_front_flip_pre=texture(card_front,vec2(1.+uv.x-time,2.-uv.y-time));
	if(time<=0.1){
		final_color=color_card_back;
	}else if(time<=0.8){
		if(uv.y - uv.x >1.0-time){
			final_color=vec4(0.0);
		}else if(uv.y>1.0-time && uv.x <time){
			//final_color=color_card_front_flip_pre;
		}else{
			final_color=color_card_back;
		}
	}else{
		final_color=vec4(0.0);
		//final_color=color_card_front;
	}
	// 处理预乘alpha（CanvasGroup必需）
    if (final_color.a > 0.0001) {
        final_color.rgb /= final_color.a;
    }
	if(enable){
		COLOR=final_color;
	}else{
		COLOR=color_screen;
	}
	//COLOR=texture(card_front,vec2(UV.x+1.-time,-UV.y+2.-time));
	//COLOR=screen;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

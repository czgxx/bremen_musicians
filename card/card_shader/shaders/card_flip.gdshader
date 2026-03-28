shader_type canvas_item;
//render_mode unshaded;
group_uniforms enable;
uniform bool enable_draw=false;
uniform bool enable_flip=false;
group_uniforms;
uniform vec2 card_size=vec2(32.,48.);
uniform float time:hint_range(0.0, 1.0, 0.01)=0.4;
uniform float speed:hint_range(0.0, 1.0, 0.01)=1.0;
group_uniforms group_texture;
// 屏幕纹理
uniform sampler2D screen_texture:hint_screen_texture,filter_nearest;


// 卡面前备缓冲区
uniform sampler2D card_front : filter_nearest;
// 卡背后备缓冲区
uniform sampler2D card_back : filter_nearest;

group_uniforms;
varying vec2 uv;
varying vec2 vertex_xy;
varying vec4 color_card_back;
varying vec4 color_card_front;
vec4 draw(){
	vec4 final_color;
	//vec4 color_card_front_flip_pre=texture(card_front,vec2(1.+uv.x-time,2.-uv.y-time))
	//vec4 color_card_front_flip_pre=texture(card_front,vec2(1.-uv.x-time,uv.y-time));
	//vec4 color_card_front_flip_pre=texture(card_front,vec2(uv.x,uv.y+time-1.));
	vec4 color_card_front_flip_pre=texture(card_front,vec2(uv.x,uv.y+time-1.));
	if(time<=0.1){
		final_color=color_card_back;
	}else if(time<=0.6){
		if(uv.y - uv.x >1.0-time){
			final_color=vec4(0.0);
		}else if(uv.y>1.0-time && uv.x <time){
			final_color=color_card_front_flip_pre;
		}else{
			final_color=color_card_back;
		}
	}else{
		final_color=color_card_front;
	}
	// 处理预乘alpha（CanvasGroup必需）
    if (final_color.a > 0.0001) {
        final_color.rgb /= final_color.a;
    }
	return final_color;
}

vec4 flip_color(){
	vec4 final_color;
	vec4 color_card_back_tmp;
	vec4 color_card_front_tmp;
	float time_2=(1.-time);
	color_card_back_tmp=texture(card_back,vec2((uv.x-1.*time_2)*(1.0/(1.0-2.*time_2)),uv.y));
	color_card_front_tmp=texture(card_front,vec2((uv.x-1.*time)*(1.0/(1.0-2.*time)),uv.y));
	if(time<=0.5){
		if(uv.x>time && uv.x<1.-time){
			final_color=color_card_front_tmp;
		}else{
			final_color=vec4(0.0);
		}
	}else if(time<=1.){
		if(uv.x>time_2 && uv.x<1.-time_2){
			final_color=color_card_back_tmp;
		}else{
			final_color=vec4(0.0);
		}
	}else{
		final_color=color_card_front;
	}
	// 处理预乘alpha（CanvasGroup必需）
    if (final_color.a > 0.0001) {
        final_color.rgb /= final_color.a;
    }
	return final_color;
}
vec2 flip_vertex(){
	vec2 final_vertex;
	
	if(time<=0.2){
		final_vertex=vec2(vertex_xy.x*time,vertex_xy.y);
	}else if(time<=0.4){
		final_vertex=vertex_xy;
	}else{
		final_vertex=vertex_xy;
	}
	return final_vertex;
}
void vertex() {
	vertex_xy=VERTEX;
	//if(VERTEX.y<0.){
		//VERTEX=VERTEX+vec2(20.,20.);
	//}
	//VERTEX=VERTEX*vec2(20.,20.);
	//VERTEX.x+=time*100.;
	//if(time<=0.1){
		//VERTEX=VERTEX;
	//}else if(time<=0.4){
		//VERTEX=VERTEX.yx;
	//}else{
		//VERTEX=VERTEX;
	//}
	
	//VERTEX=vec2(10,20)+VERTEX;
	// Called for every vertex the material is visible on.
}


void fragment() {
	
    uv = UV;
	color_card_back=texture(card_back,uv);
	color_card_front=texture(card_front,uv);
	vec4 color_screen=texture(screen_texture,SCREEN_UV);


	if(enable_draw){
		COLOR=draw();
	}else if(enable_flip){
		COLOR=flip_color();
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

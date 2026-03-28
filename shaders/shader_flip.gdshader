shader_type canvas_item;
// 正面纹理
uniform sampler2D front_texture;
// 背面纹理
uniform sampler2D back_texture;
uniform float speed_flip:hint_range(0.0, 100.0, 0.5)=20.0;
group_uniforms int1;
uniform int int1:hint_range(0, 100, 1)=2;
uniform int int2:hint_range(0, 100, 1)=2;
group_uniforms;
void vertex() {
	if (VERTEX.y<0.0 && VERTEX.x<0.0){
		VERTEX+=20.0*vec2(-(sin(TIME)-1.0),-(sin(TIME)-1.0) );
	}
	//VERTEX.xy=VERTEX.yx;
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color1=vec4(1.0,0.2,0.3,0.2);
	vec4 color2=vec4(0.0,0.9,0.9,0.2);
	
	vec4 sprite2d=texture(TEXTURE,UV);
	vec4 sprite2dfront=texture(front_texture,UV);
	vec4 sprite2dback=texture(back_texture,UV);
	vec4 color3=mix(color1,color2,sin(TIME*speed_flip));
	//COLOR=vec4(1.,0.6,0.2,0.8);
	//if(UV.y- UV.x>sin(TIME)){
		//COLOR=sprite2dback;
	//}else{
		//COLOR=sprite2dfront;
	//}
	//if(UV.y<sin(TIME)){
		//COLOR=mix(sprite2d,sprite2dback,sin(TIME));
	//}
	//COLOR=mix(sprite2d,sprite2dback,sin(TIME));
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

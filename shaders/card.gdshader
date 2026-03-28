shader_type canvas_item;  // 2D 着色器

// 控制翻转进度 (0.0 = 正面, 1.0 = 背面)
uniform float flip_progress : hint_range(0, 1) = 0.0;
// 正面纹理
uniform sampler2D front_texture;
// 背面纹理
uniform sampler2D back_texture;

void fragment() {
    // 获取当前像素的原始 UV 坐标
    vec2 uv = UV;
    
    // 计算水平方向的“压缩”效果，模拟 3D 旋转
    // 当 flip_progress < 0.5 时，压缩正面；> 0.5 时，压缩背面
    float flip_dir = sign(0.5 - flip_progress); // 翻转方向
    float flip_amount = abs(flip_progress - 0.5) * 2.0; // 压缩程度 (0-1)
    
    // 根据翻转进度调整 UV.x，让图像向中心压缩
    uv.x = (uv.x - 0.5) * (1.0 - flip_amount * 0.8) + 0.5;
    
    // 判断应该显示正面还是背面
    vec4 front_color = texture(front_texture, uv);
    vec4 back_color = texture(back_texture, uv);
    
    // 当 flip_progress < 0.5 时显示正面，否则显示背面
    COLOR = mix(front_color, back_color, step(0.5, flip_progress));
    
    // 当卡牌完全侧对屏幕时（flip_progress ≈ 0.5），让它变细或透明
    if (flip_amount > 0.9) {
        COLOR.a *= (1.0 - (flip_amount - 0.9) * 10.0);
    }
}
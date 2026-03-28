# Card.gd
#Card (Node2D)  # 挂载翻牌 Shader
#├── FrontContainer (Node2D)  # 正面容器
#│   ├── Art (Sprite2D)       # 图案（大小可能不同）
#│   └── Number (Sprite2D)    # 数字（大小可能不同）
#├── BackContainer (Node2D)    # 背面容器（统一大小）
#│   └── Back (Sprite2D)       # 卡背
#└── GlowContainer (Node2D)    # 特效容器（可选）
extends Sprite2D

@onready var shader_material = material as ShaderMaterial

var flip_duration: float = 0.3
var is_flipping: bool = false
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		flip_card()
	pass
func flip_card():
	if is_flipping:
		return
	
	is_flipping = true
	
	# 从 0 到 1 翻转
	var tween = create_tween()
	tween.tween_method(_set_flip_progress, 0.0, 1.0, flip_duration)
	await tween.finished
	
	is_flipping = false

func _set_flip_progress(value: float):
	if shader_material:
		shader_material.set_shader_parameter("flip_progress", value)

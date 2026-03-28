extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed:float=sprite_2d.material.get_shader_parameter("speed1")
	if Input.is_action_just_pressed("ui_up"):
		speed+=10
		sprite_2d.material.set_shader_parameter("speed1",speed)
	if Input.is_action_just_pressed("ui_down"):
		speed-=10
		sprite_2d.material.set_shader_parameter("speed1",speed)
	pass

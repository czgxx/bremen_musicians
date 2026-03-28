extends Node2D
var enable:=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Button.pressed.connect(
		func():
			enable= not enable
			%Button.text="flip towards mouse: \n%s" % ("enabled" if enable else "disabled")
	)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and enable:
		$Sprite2D/FlipSprite2D.flip_sprite_towards(get_global_mouse_position())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

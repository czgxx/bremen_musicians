extends Node2D
@onready var card: Card = $Card
@onready var marker_2d: Marker2D = $Marker2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				#card.move_to(Vector2.ZERO,marker_2d)
				print(card.name)
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

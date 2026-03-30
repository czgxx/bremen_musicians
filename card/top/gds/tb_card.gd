extends Node2D
@onready var card: Card = %Card
@onready var marker_2d: Marker2D = $Marker2D
@onready var card_2: Card = %Card2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				#card.move_to(Vector2.ZERO,marker_2d)
				print(card.name)
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card.move_to(Vector2(30,55))
	card_2.move_to(Vector2(80,39))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

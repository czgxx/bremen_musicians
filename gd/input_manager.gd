extends Node2D
#@export var deck:Deck
#@onready var card_manager: Node2D = $"../CardManager"
signal left_mouse_pressd
signal left_mouse_released

#func _unhandled_input(event: InputEvent) -> void:
	#print(event.as_text())
	#if event is InputEventMouseButton :
		#if event.is_action_pressed("mouse_left"):
			##var card=raycast_at_cursor()
			#emit_signal("left_mouse_pressd")
		#else:
			#emit_signal("left_mouse_released")
	#pass


	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#raycast_at_cursor()
	pass

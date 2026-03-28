extends Node2D
@onready var timer: Timer = %Timer

#region all signal
#region area_2d signal
#signal mouse_entered
#signal mouse_exited
signal area_entered
signal area_exited
signal input_event
func _on_area_2d_mouse_entered() -> void:
	#emit_signal("mouse_entered",self)
	pass # Replace with function body.

func _on_area_2d_mouse_exited() -> void:
	#emit_signal("mouse_exited",self)
	pass # Replace with function body.

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	emit_signal("input_event",self,viewport, event, shape_idx)
	pass # Replace with function body.

func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("area_entered",self,area)
	pass # Replace with function body.

func _on_area_2d_area_exited(area: Area2D) -> void:
	emit_signal("area_exited",self,area)
	pass # Replace with function body.
#endregion
#region button signal
signal button_down
signal button_up
signal pressed
signal mouse_entered
signal mouse_exited
func _on_button_pressed() -> void:
	emit_signal("pressed",self)
	pass # Replace with function body.

func _on_button_button_up() -> void:
	emit_signal("button_up",self)
	pass # Replace with function body.


func _on_button_button_down() -> void:
	emit_signal("button_down",self)
	#print("_on_button_button_up")
	pass # Replace with function body.


func _on_button_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
	

func _on_button_mouse_entered() -> void:
	emit_signal("mouse_entered",self)
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	emit_signal("mouse_exited",self)
	pass # Replace with function body.
#endregion
#endregion

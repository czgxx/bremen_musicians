extends Node2D
class_name Magnetism
var card:Card=null
var enable:bool=true
func _init(enable:bool=true,name:String="Magnetism"):
	print("Magnetism setup")
	self.enable=enable
	self.name=name
	pass
func attract():
	var neighbor:Array[Card]=card.card_data.neighbor
	if neighbor.size()!=0:
		for i in neighbor:
			if i.card_data.moving==false:
				i.move_to(self.global_position)
		pass
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card=Global.check_parent_group(self,"Card")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if card and enable:
		attract()
	pass

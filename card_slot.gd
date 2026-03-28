extends Node2D
class_name CardSlot
var card_slots:Array[Card]
@rpc("any_peer", "call_local", "reliable")
func spawn_slot(num:int=0):
	var card:Card=Global.CARD.instantiate()
	#add_child(card)
	var card_front:Texture=load(str(Global.sprites_root_path+Global.CARD_COLOR_NAME[Global.CARD_COLOR.SLOT]+".png"))
	var card_back:Texture=load(str(Global.sprites_root_path+Global.CARD_COLOR_NAME[Global.CARD_COLOR.SLOT]+".png"))
	
	card.card_movement.enable=false
	card.card_high_light.enable=false
	card.card_image.detect.visible=false
	#var magnetism=Magnetism.new()
	#card.add_child(magnetism)
	#card_slots.append(card)
	return card
pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

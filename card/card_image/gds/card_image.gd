extends Node
class_name CardImage
#@onready var card_front: CardFront = $CardFront
#@onready var card_back: CardBack = $CardBack
#var card_front_tex:Texture2D
#var card_back_tex:Texture2D
@onready var card_back: CardBack = %CardBack
@onready var card_front: CardFront = %CardFront
@export var card:Card
#@export var time:float:
	#set(value):
		#time=value
		##shader_params["time"]=time
		##shader_params["enable"]=true
		##ShaderManager.apply_card_shader(card_front, "card_front_flip", shader_params)
		##ShaderManager.apply_card_shader(card_back, "card_back_flip", shader_params)
		##ShaderManager.apply_card_shader(self, "card_flip", shader_params))
		#card_front.visible=false
		#card_back.visible=false
		#material.set_shader_parameter("time", time)
		#material.set_shader_parameter("enable", true)
		#material.set_shader_parameter("card_front", card_front_tex)
		#material.set_shader_parameter("card_back", card_back_tex)
#
#
#var shader_params = {
	#"time"=0.0,
	#"enable"=false,
	#"card_front"=null,
	#"card_back"=null,
#}
#var my_material 
## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card=Global.find_parent_in_group(self,"Card")
	pass

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_show_face()
	pass
#
#
func _show_face():
	if card.card_data.is_face_up:
		card_front.visible=true
		card_back.visible=false
	else:
		card_front.visible=false
		card_back.visible=true
func change_suit(suit:CardData.SUIT):
	card_front.suit.texture=load("res://card/card_image/sprites/card_suit"+
	str(suit)+".png")
func change_num(num:int):
	card_front.num.text=str(num)

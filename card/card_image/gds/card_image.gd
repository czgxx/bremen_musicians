extends Node
#@onready var card_front: CardFront = $CardFront
#@onready var card_back: CardBack = $CardBack
#var card_front_tex:Texture2D
#var card_back_tex:Texture2D
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
#func _ready() -> void:
	#
	#my_material = ShaderMaterial.new()
	#my_material.shader = preload("res://card/card_shader/shaders/card_flip.gdshader")
	#material = my_material
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	##print(sin(Time.get_ticks_msec()/1000)/2+0.5)
	##if shader_params["card_front"] and shader_params["card_back"]:
		##time=sin(Time.get_ticks_msec()/1000)/2+0.5
		##print("setup")
	#pass
#
#
#func _on_card_front_texture_ready(card_front,texture:Texture2D) -> void:
	#print("card_front.card_texture is ok")
	#shader_params["card_front"]=texture
	#card_front_tex=texture
	##material.set_shader_parameter("card_front", texture)
	##ShaderManager.apply_card_shader(self, "card_flip", shader_params)
	##ShaderManager.apply_card_shader(card_front, "card_front_flip", shader_params)
	#pass # Replace with function body.
#
#
#func _on_card_back_texture_ready(card_back,texture: Texture2D) -> void:
	#print("card_back.card_texture is ok")
	#shader_params["card_back"]=texture
	#card_back_tex=texture
	##material.set_shader_parameter("card_back", texture)
	#
	##ShaderManager.apply_card_shader(self, "card_flip", shader_params)
	##ShaderManager.apply_card_shader(card_back, "card_back_flip", shader_params)
	#pass # Replace with function body.
##func card_face_or_back():
	##if animation_player:
		##if animation_player.is_playing():
			##if self.scale.x<0 or self.scale.y<0:
				##background.visible=false
				##sprite_2d_back.visible=true
			##else:
				##background.visible=true
				##sprite_2d_back.visible=false
				##
	##pass

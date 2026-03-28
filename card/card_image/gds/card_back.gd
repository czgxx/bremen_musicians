extends Node2D
#extends SubViewport
class_name CardBack

signal texture_ready(node,texture:Texture2D)
@onready var save_path="res://card/card_image/sprites/card_back.png"
@onready var background: Sprite2D = %Background

@export var card_image_data:CardImageData=CardImageData.new()
#var card_size:Vector2=Vector2(64,96)
var texture:Texture2D
#var card_data:CardData
var card:Card
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#card_size=sprite_2d_back.texture.get_size()
	#
	#var rect = Rect2i(0, 0, card_size.x, card_size.y)
	#card_texture=await save_texture(self,rect,save_path)
	#texture_ready.emit(self,card_texture)
	get_card_data()
	#card_data=card.card_data
	if card:
		card_image_data=card.card_data.card_back
		card_image_data.add_image(background)
		card_image_data.changed.connect(_card_image_data_changed)
		save_texture()
	pass # Replace with function body.

func save_texture():
	#card_size=background.texture.get_size()
	var card_size=card_image_data.card_size
	var rect = Rect2i(0, 0, card_size.x, card_size.y)
	texture=await CardImageData.save_texture(self,rect,save_path)
	texture_ready.emit(self,texture)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func get_card_data():
	card=Global.find_parent_in_group(self,"Card")
	if card == null:
		return 
func _card_image_data_changed(property_name, old_value, new_value):
	match(old_value):
		"add":
			add_child(new_value)
			print(self.name+" add:"+new_value.name)
		"remove":
			remove_child(new_value)
			print(self.name+" remove:"+new_value.name)
		"modify":
			pass
	#if property_name=="image":
		#match(old_value):
			#"add":
				#add_child(new_value)
			#"remove":
				#remove_child(new_value)
		##modify_chlid(card_image_data.images_data)
	#if property_name=="label":
		#match(old_value):
			#"add":
				#add_child(new_value)
			#"remove":
				#remove_child(new_value)
		##modify_chlid(card_image_data.labels_data)

	#save_texture()
func modify_chlid(new_children):
		if new_children.size()==0:
			return
		var old_children_name:Array=[]
		for child in get_children():
			old_children_name.append(child.name)
		for child:Node in new_children:
			if old_children_name.has(child.name):
				print("old_children_name")
				#var old_child=get_node(str(child.name))
				remove_child(get_node(str(child.name)))
				add_child(child)
				#old_child=child.duplicate()
			else:
				add_child(child)

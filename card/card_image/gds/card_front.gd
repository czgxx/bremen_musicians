extends CardBack
class_name CardFront

@onready var suit: Sprite2D = $Suit
@onready var num: Label = $Num


#signal texture_ready(node,texture:Texture2D)
#@onready var save_path="res://card/card_image/sprites/card_front.png"
#@onready var background: Sprite2D = $Background
#@export var card_image_data:CardImageData=CardImageData.new()
#var card_size:Vector2=Vector2(64,96)
#var texture:Texture2D
#var card_data:CardData
#var card:Card
# Called when the node enters the scene tree for the first time.
#func get_card_data():
	#card=Global.find_parent_in_group(self,"Card")
	#if card == null:
		#return 
	#card_data=card.card_data
#func _card_data_changed(property_name, old_value, new_value):
	#pass
#func _card_image_data_changed(property_name, old_value, new_value):
	#
	#if property_name=="images_data":
		#if card_image_data.images_data.size()==0:
			#return
		#for image_data:Sprite2D in card_image_data.images_data:
			##var children_name:Array
			##for child in get_children():
				##if child is Sprite2D:
					##children_name[child.get_index()]=child.name
			#
			#if get_children().has(image_data):
				##var sprite_2d:Sprite2D=get_node(image_data.name)
				#image_data=image_data
				#
			#else:
				##var new_sprite=Sprite2D.new()
				##new_sprite.texture=image_data.texture
				#add_child(image_data)
				#
#
	#if property_name=="labels_data":
		#if card_image_data.labels_data.size()==0:
			#return
		#for label_data:Label in card_image_data.labels_data:
			#var children_name:Array
			#for child in get_children():
				#if child is Label:
					#children_name[child.get_index()]=child.name
			#
			#if get_children().has(label_data):
				##var label:Label=get_node(label_data.name)
				#label_data=label_data
			#else:
				##var new_label=Label.new()
				##new_label.text=label_data.text
				#add_child(label_data)
	#
	#save_texture()
##func save_texture():
	###card_size=background.texture.get_size()
	##var card_size=card_image_data.card_size
	##var rect = Rect2i(0, 0, card_size.x, card_size.y)
	##texture=await CardImageData.save_texture(self,rect,save_path)
	##texture_ready.emit(self,texture)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save_path="res://card/card_image/sprites/card_front.png"
	background = $Background
	get_card_data()
	if card:
		card_image_data=card.card_data.card_front
		
		card_image_data.add_image(background)
		card_image_data.add_image(suit)
		card_image_data.add_label(num)
		card_image_data.changed.connect(_card_image_data_changed)
		save_texture()
	
	

	
	#card_size=sprite_2d_front.texture.get_size()
	#await RenderingServer.frame_post_draw
	## 5. 从视口抓取纹理
	#var viewport_texture = get_viewport().get_texture()
	#
	## 6. 从全屏纹理中截取出画板所在区域
	#var viewport_image = viewport_texture.get_image()
	#var rect = Rect2i(0, 0, card_size.x, card_size.y)
	#var card_image = viewport_image.get_region(rect)
	#card_texture=ImageTexture.create_from_image(card_image)
	#card_image.save_png(save_path)
	#texture_ready.emit(self,card_texture)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

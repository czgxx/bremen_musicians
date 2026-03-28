# CardVisualResource.gd
extends Resource
class_name CardImageData
# ========== 基础信息 ==========
@export_category("📋 基础信息")
@export var card_id: String = ""
# ========== 卡片尺寸 ==========
@export_category("📐 卡片尺寸")
@export var card_size: Vector2 = Vector2(64, 96)
# ========== 图案设置 ==========
@export_category("🖼️ 图案设置")
#var art_data:Dictionary={
	#"Background"={
		#"art_texture"=preload("res://card/card_image/sprites/card_face.png"),
		#"art_position"= Vector2(0, 0),  # 中心点位置
		#"art_scale"= Vector2(1, 1),
		#"art_rotation"= 0.0,
		#"art_modulate"= Color.WHITE,
	#}
#}

var _images_data:Array[Sprite2D]:
	set(value):
		_images_data=value
		pass
func get_images() -> Array:
	return _images_data.duplicate(true)

func add_image(sprite_2d:Sprite2D):
	if _images_data.has(sprite_2d):
		return
	else:
		_images_data.append(sprite_2d)
	changed.emit("image","add",sprite_2d)
	print(card_id+" add_image:"+sprite_2d.name)
func remove_image(sprite_2d:Sprite2D):
	if not _images_data.has(sprite_2d):
		return
	else:
		_images_data.erase(sprite_2d)
	changed.emit("image","remove",sprite_2d)
	print(card_id+" remove_image:"+sprite_2d.name)
func has(name:String)->bool:
	for i in _images_data:
		if i.name==name:
			return true
	for i in _labels_data:
		if i.name==name:
			return true
	
	return false
		
	pass
static func save_texture(node,rect,path):
	var children=node.get_children()
	
	# 创建 SubViewport
	var viewport = SubViewport.new()
	viewport.size = Vector2i(500, 500)
	viewport.transparent_bg = true
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	node.add_child(viewport)

	# 把你的卡牌放进去
	
	for sprite in children:
		var card = sprite.duplicate()
		viewport.add_child(card)

	
	await RenderingServer.frame_post_draw
	# 5. 从视口抓取纹理
	var viewport_texture = viewport.get_texture()
	
	# 6. 从全屏纹理中截取出画板所在区域
	var viewport_image = viewport_texture.get_image()
	var card_image = viewport_image.get_region(rect)
	card_image.save_png(path)
	node.remove_child(viewport)
	var texture=ImageTexture.create_from_image(card_image)
	return texture
	
	# 2. 在 SubViewport 里放一个简单的彩色方块
	#var color_rect = ColorRect.new()
	#color_rect.size = Vector2(300, 400)
	#color_rect.color = Color.RED  # 醒目的红色
	#viewport.add_child(color_rect)
	
	## 3. 创建一个 Sprite2D 来显示这个 SubViewport 的渲染结果
	#var preview = Sprite2D.new()
	#preview.position = Vector2(400, 400)  # 放在屏幕右侧
	#node.add_child(preview)
	#
	## 4. 把 SubViewport 的纹理赋给 Sprite2D
	#preview.texture = viewport.get_texture()
	#print("纹理大小: ", preview.texture.get_size())
	
# ========== 数字 ==========
@export_category("🔢 标签")
#var label_data:Dictionary={
	#"num"=0,
	#"num_position"= Vector2(0, 0),  # 中心点位置
	#"num_scale"= Vector2(1, 1),
	#"num_rotation"= 0.0,
	#"num_modulate"= Color.WHITE,
#}
var _labels_data:Array[Label]:
	set(value):
		_labels_data=value
		pass
func get_labels() -> Array:
	return _labels_data.duplicate(true)
func add_label(label:Label):
	if _labels_data.has(label):
		return
	else:
		_labels_data.append(label)
		
	changed.emit("label","add",label)
	print(card_id+" add_label:"+label.name)

func remove_label(label:Label):
	if not _labels_data.has(label):
		return
	else:
		_labels_data.erase(label)
		
	changed.emit("label","remove",label)
	print(card_id+" remove_label:"+label.name)

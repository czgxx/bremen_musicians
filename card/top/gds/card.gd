
extends Node2D
class_name Card
@export var card_data:CardData=CardData.new()
@onready var card_animation: AnimationPlayer = $CardAnimation
func fsm():
	match(card_data.state):
		CardData.STATE.IDEAL:
			if(card_data.is_top_card):
				card_data.state=CardData.STATE.HOVER_ON
			pass
		CardData.STATE.HOVER_ON:
			if(not card_data.is_top_card):
				card_data.state=CardData.STATE.IDEAL
			elif(Input.is_action_pressed("mouse_left")):
				card_data.state=CardData.STATE.MOVE
		CardData.STATE.MOVE:
			if(not card_data.is_top_card):
				card_data.state=CardData.STATE.IDEAL
			elif(Input.is_action_just_released("mouse_left")):
				card_data.state=CardData.STATE.HOVER_ON
	pass
func add_sprite(name,texture,position:=Vector2(0,0)):
	var new_image_data:Sprite2D=Sprite2D.new()
	new_image_data.texture=texture
	new_image_data.name=name
	new_image_data.position=position
	card_data.card_front.add_image(new_image_data)
func add_label(name,text,position:=Vector2(0,0)):
	var new_label:Label=Label.new()
	new_label.text=text
	new_label.modulate=Color.BLACK
	new_label.name=name
	new_label.position=position
	#add_child(new_label)
	card_data.card_front.add_label(new_label)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signal()
	card_data.card_name="czg"
	#move_to(Vector2(300,600))
	#flip_to(false)
	#flip_to(true)
	draw_to(false)
	#add_sprite("Suit",preload("uid://bj8pc7rbhltbn"),Vector2(10,30))
	#add_label("Label","6",Vector2(15,0))
	#card_state.auto_hover=true
	pass # Replace with function body.
func _card_data_changed(property_name, old_value, new_value):
	if property_name=="card_name":
		self.name=card_data.card_name
	print("_card_data_changed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	fsm()
	if Input.is_action_just_pressed("ui_accept"):
		add_label("Label",str(randi()% 10),Vector2(10,10))
	#card_face_or_back()
	#card_state.fliping=true
	pass

@rpc("any_peer", "call_local", "reliable")
func move_to(to:Vector2=Vector2.ZERO,node: Node = get_parent()):
	##reparent(node)
	card_animation.modify_keyframe_value("move", 0, 0, self.global_position)
	card_animation.modify_keyframe_value("move", 0, 1, to)
	card_animation.play("move")
	#card_movement.move_to.rpc(to)
	pass
@rpc("any_peer", "call_local", "reliable")
func flip_to(face_up:bool=true,flip_type:String="flip_lr"):
	if face_up:
		if card_data.is_face_up:
			return
		else:
			card_data.is_face_up=true
			card_animation.play_backwards(flip_type)
	else:
		if card_data.is_face_up:
			card_data.is_face_up=false
			card_animation.play(flip_type)
		else:
			return
	##reparent(node)
	#card_animation.modify_keyframe_value("move", 0, 1, to)
	#card_animation.play("flip")
	#card_movement.move_to.rpc(to)
	pass
func draw_to(face_up:bool=true):
	if face_up:
		if card_data.is_face_up:
			return
		else:
			card_data.is_face_up=true
			card_animation.play("draw")
	else:
		if card_data.is_face_up:
			card_data.is_face_up=false
			card_animation.play_backwards("draw")
		else:
			return
	pass
#func flip_card_to_face_up():
	#card_data.is_face_up=true
#func flip_card_to_back_up():
	#card_data.is_face_up=false
#region all signal
func connect_signal():
	card_data.changed.connect(_card_data_changed)
	SignalBus.top_card_changed.connect(_on_top_card_changed)

	pass
	
func _on_top_card_changed(card):
	if self==card:
		card_data.is_top_card=true
		card_animation.play("hover")
	else:
		card_data.is_top_card=false
		card_animation.play_backwards("hover")
	pass
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT and card_data.is_top_card:
			if event.pressed:
				card_animation.play("draw")
			else:
				card_animation.play_backwards("draw")

#region area_2d signal
signal area_entered
signal area_exited
signal input_event
func _on_area_2d_mouse_entered() -> void:
	#print("hovered on")
	SignalBus.card_area_mouse_entered.emit(self)
	pass # Replace with function body.

func _on_area_2d_mouse_exited() -> void:
	#print("hovered off")
	SignalBus.card_area_mouse_exited.emit(self)
	pass # Replace with function body.

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	emit_signal("input_event",self,viewport, event, shape_idx)
	SignalBus.card_area_input_event.emit(self,viewport, event, shape_idx)
	pass # Replace with function body.

func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("area_entered",self,area)
	SignalBus.card_area_entered.emit(self,area)
	#print(card_enter.name)
	pass # Replace with function body.

func _on_area_2d_area_exited(area: Area2D) -> void:
	emit_signal("area_exited",self,area)
	SignalBus.card_area_exited.emit(self,area)
	pass # Replace with function body.
#endregion

#endregion

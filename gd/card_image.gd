extends Node2D
class_name CardImage
@onready var label: Label = %Label
@onready var background: Sprite2D = %Sprite2DFront
@onready var sprite_2d_back: Sprite2D = %Sprite2DBack
@onready var sprite_2d_suit: Sprite2D = %Sprite2DSuit


@onready var detect: Node2D = %Detect
var card:Card=null
@export var enable:bool=true:
	set(value):
		if value:
			self.visible=enable
		else :
			self.visible=false
var _card_shake:CardShake
var card_shake:CardShake:
	set(value):
		# 1. 类型检查
		if value != null and not (value is CardShake):
			push_error("card_face 必须是 CardFace 类型")
			return
		
		# 2. 新旧数据比较
		if _card_face == value:
			return
		
		# 3. 更新数据	

		card_shake=value

var _card_flip:CardFlip
var card_flip:CardFlip:
	#get:
		#var card_flip:CardFlip
		#card_flip.scale_front=self.background.scale
		#card_flip.scale_back=self.sprite_2d_back.scale
		#return card_flip
	set(value):
		# 1. 类型检查
		if value != null and not (value is CardFlip):
			push_error("card_face 必须是 CardFace 类型")
			return
		
		# 2. 新旧数据比较
		if _card_face == value:
			return
		
		# 3. 更新数据	
		#if card and self.background:
			#self.background.scale=value.scale_front
		#if card and self.sprite_2d_back:
			#self.sprite_2d_back.scale=value.scale_back
			
		card_flip=value
	
var _card_face: CardFace
var card_face:CardFace:
	set(value):
		# 1. 类型检查
		if value != null and not (value is CardFace):
			push_error("card_face 必须是 CardFace 类型")
			return
		
		# 2. 新旧数据比较
		if _card_face == value:
			return
		
		# 3. 更新数据
		_card_face = value
		print("卡牌面板更新: ", str(_card_face.card_num))
		
		# 4. 触发更新
		if label:
			if card_face.card_num!=_card_face.card_num:
				#print("label is ready---------------------------")
				if _card_face.card_num==11:
					label.text="J"
				elif _card_face.card_num==12:
					label.text="Q"
				elif _card_face.card_num==13:
					label.text="K"
				elif _card_face.card_num==14:
					label.text="A"
				elif _card_face.card_num==15:
					label.text="2"
				elif _card_face.card_num==16:
					label.text="g"
				elif _card_face.card_num==17:
					label.text="G"
				elif _card_face.card_num>=3 and _card_face.card_num<=10:
					label.text=str(_card_face.card_num)
				elif _card_face.card_num>=18 or _card_face.card_num<=2:
					label.text="???????????"
			else:
				#print("label is not ready---------------------------")
				pass
		if _card_face.card_front and card and self.background:
			if card_face.card_front!=_card_face.card_front:
				self.background.texture=_card_face.card_front
		if _card_face.card_back and card and self.sprite_2d_back:
			if card_face.card_back!=_card_face.card_back:
				self.sprite_2d_back.texture=_card_face.card_back
		if card and self.sprite_2d_suit:
			if card_face.card_suit!=_card_face.card_suit:
				match _card_face.card_suit:
					CardFace.SUIT.SPADE:
						self.sprite_2d_suit.texture=load("res://sprites/card_suit1.png")
					CardFace.SUIT.HEART:
						self.sprite_2d_suit.texture=load("res://sprites/card_suit2.png")
					CardFace.SUIT.CLUB:
						self.sprite_2d_suit.texture=load("res://sprites/card_suit3.png")
					CardFace.SUIT.DIAMOND:
						self.sprite_2d_suit.texture=load("res://sprites/card_suit4.png")
				
		
		card_face=value
class CardFace:
	var card:Card
	enum SUIT {SPADE,HEART,CLUB,DIAMOND,SLOT}
	var card_num:int:
		set(value):
			# 1. 类型检查
			if value != null and not (value is int):
				push_error("card_face 必须是 CardFace 类型")
				return
			card_num=clampi(value,3,17)
	var card_suit:SUIT
	var card_front:Texture:
		set(value):
			# 1. 类型检查
			if value != null and not (value is Texture):
				push_error("card_face's card_front 必须是 Texture 类型")
				return
			
			card_front=value
	var card_back:Texture:
		set(value):
			# 1. 类型检查
			if value != null and not (value is Texture):
				push_error("card_face's card_back 必须是 Texture 类型")
				return
			
			card_back=value
	func _init(
		card:Card,
		card_num:int=3,
		card_suit:SUIT=SUIT.SPADE,
		card_front:Texture=load("res://sprites/card_face.png"),
		card_back:Texture=load("res://sprites/card_back.png")
		):
		self.card=card
		self.card_num=card_num
		self.card_suit=card_suit
		self.card_front=card_front
		self.card_back=card_back
#func _enter_tree() -> void:
	#setup()
func _init(
	name:String="Image",
	enable:bool=true
	):
	print("Image setup： enable="+str(enable)+",name="+name)
	self.enable=enable
	self.name=name
	_card_face=CardFace.new(card)
	card_face=CardFace.new(card)
	_card_flip=CardFlip.new(card)
	card_flip=CardFlip.new(card)
	_card_shake=CardShake.new(card)
	card_shake=CardShake.new(card)
	pass
func setup(
	card_num:int=3,
	card_front:Texture=load("res://sprites/club.png"),
	card_back:Texture=load("res://sprites/slot.png")
	):
	if card:
		print("setup image")
		self.card_face=card.card_data.card_face
		card_flip.background=background
		card_flip.sprite_2d_back=sprite_2d_back
		card_shake.background=background
		card_shake.sprite_2d_back=sprite_2d_back
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card=Global.check_parent(self,"Card")
	setup()
	detect.timer.start(1)
	pass
func _physics_process(delta: float) -> void:
	#card_flip.flip(3,CardFlip.FLIP_TYPE.H)
	#background.scale.x+=2*delta
	if card:
		if enable:
			card_flip.flip(delta)
			card_shake.shake(delta)
			#print(card_shake.enable)
			pass
			#if card.card_state.fliping:
				#card_flip.flip(3,delta,CardFlip.FLIP_TYPE.H)
				#pass
#region 翻转类
class CardFlip:
	var card:Card
	const MAX_FLIP_NUM=100
	const MAX_FLIP_AMP=2
	const MAX_FLIP_SPEED=10
	enum FLIP_TYPE {H,V,H_2,V_2}
	enum STATE {IDEAL,INIT,FLIP,OVER}
	var enable:bool
	var state:STATE
	var is_face_up:bool
	var background:Sprite2D
	var sprite_2d_back:Sprite2D
	var flip_type:FLIP_TYPE
	var flip_num:int:
		set(value):
			flip_num=clamp(value,0,MAX_FLIP_NUM)
	var flip_amp:float:
		set(value):
			flip_amp=clamp(value,0,MAX_FLIP_AMP)
	var flip_amping:float:
		set(value):
			flip_amping=clamp(value,0,MAX_FLIP_AMP)
	var flip_direction:int:
		set(value):
			if value>0:
				flip_direction=1
			else:
				flip_direction=-1
	var speed:float:
		set(value):
			speed=clamp(value,0.01,MAX_FLIP_SPEED)
	
	#region 构造函数
	func _init(
		card:Card,
		background:Sprite2D=null,
		sprite_2d_back:Sprite2D=null
		):
			self.card=card
			enable=false
			state=STATE.IDEAL
			is_face_up=true
			if background:
				self.background=background
				#self.background.scale=Vector2.ONE
			if sprite_2d_back:
				self.sprite_2d_back=sprite_2d_back
				#self.sprite_2d_back.scale=Vector2.ZERO
			flip_type=FLIP_TYPE.V
			flip_amp=2
			flip_amping=0
			speed=3
#endregion
			
	#region 翻转函数
	func start(flip_num:int=1):
		self.flip_num=MAX_FLIP_NUM-flip_num
		self.enable=true
		pass
	@rpc("any_peer", "call_local", "reliable")
	func flip(
		delta:float=0.01
		):
		self.flip_mode0(delta)
		self.state_machine()
		self.update_state()
		#print("flip state is:"+str(state)+" front scale is"+str(background.scale)+" back scale is"+str(sprite_2d_back.scale))
		#print("flip_amping"+str(flip_amping))
		pass
	func update_state():
		if state==STATE.IDEAL:
			pass
		if state==STATE.OVER:
			flip_num+=1
		if flip_num==MAX_FLIP_NUM:
			enable=false
		if background.scale.x<=0 or background.scale.y<=0:
			background.visible=false
		else:
			background.visible=true
		if sprite_2d_back.scale.x<=0 or sprite_2d_back.scale.y<=0:
			sprite_2d_back.visible=false
		else:
			sprite_2d_back.visible=true
		pass
	func flip_mode0(delta:float):
		#var delta=Engine.get_physics_interpolation_fraction()
		#print(delta)
		match state:
			STATE.IDEAL:
				flip_amping=0
				if background.scale.x>0 and background.scale.y>0:
					is_face_up=true
				else:
					is_face_up=false
				if is_face_up:
					background.scale=Vector2.ONE
					if flip_type==FLIP_TYPE.V:
						sprite_2d_back.scale=Vector2(-1,1)
					else:
						sprite_2d_back.scale=Vector2(1,-1)
					flip_direction=-1
				else:
					if flip_type==FLIP_TYPE.V:
						background.scale=Vector2(-1,1)
					else:
						background.scale=Vector2(1,-1)
					sprite_2d_back.scale=Vector2.ONE
					flip_direction=1
				pass
			STATE.FLIP:
				flip_amping+=speed*delta
				match flip_type:
					FLIP_TYPE.V:
						background.scale.x=clamp(background.scale.x+flip_direction*speed*delta,-1,1)
						sprite_2d_back.scale.x=clamp(sprite_2d_back.scale.x-flip_direction*speed*delta,-1,1)
						background.scale.y=1
						sprite_2d_back.scale.y=1
					FLIP_TYPE.H:
						background.scale.y=clamp(background.scale.y+flip_direction*speed*delta,-1,1)
						sprite_2d_back.scale.y=clamp(sprite_2d_back.scale.y-flip_direction*speed*delta,-1,1)
						background.scale.x=1
						sprite_2d_back.scale.x=1
			
		pass
	#endregion
	#region 状态机
	func state_machine():
		match state:
			STATE.IDEAL:
				if enable and not flip_num==MAX_FLIP_NUM:
					state=STATE.FLIP
			STATE.INIT:
				state=STATE.FLIP
			STATE.FLIP:
				if flip_amping>=flip_amp: 
					state=STATE.OVER
				pass
			STATE.OVER:
				state=STATE.IDEAL
				pass
				#if(scale_dly>0 and x<=-scale_dly):
					#state=STATE.IDEAL
					#card.card_data.flip_h=false
					#card.card_data.flip_v=false
				#elif(scale_dly<0 and x>=-scale_dly):
					#state=STATE.IDEAL
					#card.card_data.flip_h=false
					#card.card_data.flip_v=false
		pass
#endregion


#endregion

#region 震动

class CardShake:
	var card:Card
	var enable:bool
	var state:STATE
	var degree_inc:float
	var amp:float
	enum STATE {IDEAL,CLOCKWISE,COUNTER_CLOCKWISE,OVER}
	var background:Sprite2D
	var sprite_2d_back:Sprite2D
	var speed:float:
		set(value):
			speed=clamp(value,0.01,500)
	

	func _init(
		card:Card,
		background:Sprite2D=null,
		sprite_2d_back:Sprite2D=null
		):
			self.card=card
			enable=false
			state=STATE.IDEAL
			degree_inc=0.1
			amp=10
			speed=100
			if background:
				self.background=background
				#self.background.scale=Vector2.ONE
			if sprite_2d_back:
				self.sprite_2d_back=sprite_2d_back
				#self.sprite_2d_back.scale=Vector2.ZERO
			

	func state_machine():
		match state:
			STATE.IDEAL:
				if enable:
					state=STATE.CLOCKWISE
			STATE.CLOCKWISE:
				if enable==false:
					state=STATE.OVER
				elif background.global_rotation_degrees >=  abs(amp):
					state=STATE.COUNTER_CLOCKWISE
				pass
			STATE.COUNTER_CLOCKWISE:
				if enable==false:
					state=STATE.OVER
				elif background.global_rotation_degrees <= -abs(amp):
					state=STATE.CLOCKWISE
				pass
			STATE.OVER:
				state=STATE.IDEAL
	
	@rpc("any_peer", "call_local", "reliable")
	func shake(delta:float):
		shake_process(delta)
		state_machine()
	@rpc("any_peer", "call_local", "reliable")
	func shake_process(delta:float):
		#print(state)
		degree_inc=speed*delta
		#degree_inc=speed*get_physics_process_delta_time()
		if state==STATE.CLOCKWISE:
			#print("STATE.CLOCKWISE")
			background.global_rotation_degrees+=degree_inc
			sprite_2d_back.global_rotation_degrees+=degree_inc
		elif state==STATE.COUNTER_CLOCKWISE:
			#print("STATE.COUNTER_CLOCKWISE")
			background.global_rotation_degrees-=degree_inc
			sprite_2d_back.global_rotation_degrees-=degree_inc
		else:
			background.global_rotation_degrees=0
			sprite_2d_back.global_rotation_degrees=0
			
		

		background.global_rotation_degrees=clamp(background.global_rotation_degrees,-abs(amp),abs(amp))
		sprite_2d_back.global_rotation_degrees=clamp(sprite_2d_back.global_rotation_degrees,-abs(amp),abs(amp))
		pass
#endregion


func get_card_size() -> Vector2:
	if background and background.texture:
		return background.texture.get_size() * background.global_scale
	return card.card_data.card_size  # 默认扑克牌尺寸

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
	#print("area_2d:"+area.get_parent().get_parent().card.name+"entered")
	emit_signal("area_entered",card,area)
	SignalBus.card_area_entered.emit(card,area)
	pass # Replace with function body.

func _on_area_2d_area_exited(area: Area2D) -> void:
	#print("area_2d:"+area.get_parent().get_parent().card.name+"exited")
	emit_signal("area_exited",card,area)
	SignalBus.card_area_exited.emit(card,area)
	pass # Replace with function body.
#endregion
#region button signal
signal button_down
signal button_up
signal pressed
signal mouse_entered
signal mouse_exited
func _on_button_pressed() -> void:
	#card_flip.flip(5,0.01)
	emit_signal("pressed",self)
	pass # Replace with function body.

func _on_button_button_up() -> void:
	#print("_on_button_button_up")
	SignalBus.card_button_up.emit(card)
	emit_signal("button_up",self)
	pass # Replace with function body.


func _on_button_button_down() -> void:
	emit_signal("button_down",self)
	SignalBus.card_button_down.emit(card)
	#print("_on_button_button_up")
	pass # Replace with function body.


func _on_button_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
	

func _on_button_mouse_entered() -> void:
	SignalBus.card_mouse_entered.emit(card)
	emit_signal("mouse_entered",self)
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	SignalBus.card_mouse_exited.emit(card)
	emit_signal("mouse_exited",self)
	pass # Replace with function body.
#endregion
#region timer signal
signal timeout
func _on_timer_timeout() -> void:
	emit_signal("timeout",self)
	#card_flip.flip()
	pass # Replace with function body.
#endregion

#endregion

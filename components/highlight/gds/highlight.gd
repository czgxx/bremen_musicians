extends Node2D
class_name CardHighLight
var card_scale_dly:Vector2=Vector2.ZERO
var card_pos_dly:Vector2=Vector2.ZERO
var card_z_index_dly:float=1
var card:Card=null
@export var enable:bool=false
var switch:bool=false

enum STATE {IDEAL,WORK,OVER}
var state:STATE=STATE.IDEAL
func state_machine():
	match state:
		STATE.IDEAL:
			if enable:
				state=STATE.WORK
			pass
		STATE.WORK:
			if !enable:
				state=STATE.OVER
			pass
		STATE.OVER:
			state=STATE.IDEAL
			pass
func _init(name:String="CardHighLight"):
	print("CardHighLight setup")
	self.name=name
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	SignalBus.top_card_changed.connect(_on_top_card_changed)
	card=Global.check_parent(self,"Card")
	if(card != null):
		card_scale_dly=card.scale
		card_z_index_dly=card.z_index
		card_pos_dly=card.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(card):
		pass
		#print(card.card_data.highlighting)
		#print(CardManager.card_max_z.z_index)
		#highlight()
	pass

func _on_top_card_changed(card:Card):
	#if self.card==card and enable:
		#self.card.scale=Vector2(1.2,1.2)
		#self.card.z_index=1
		#print(self.card.name+"is the top card with z_index = "+str(self.card.z_index))
	#else:
		#self.card.scale=Vector2(1,1)
		#self.card.z_index=0
	pass	
	
func update_state():
	
	pass
func highlight():
	state_machine()
	highlight_process()
	update_state()
	pass
func highlight_process():
		
		
	if enable:
		switch=true
		#card.scale=card_scale_dly+Vector2(0.2,0.2)
		card.scale=Vector2(1.2,1.2)
		card.z_index=1
		#card.global_position=card_pos_dly+Vector2(0,5)
	elif card.card_state.moving:
		switch=true
		card.z_index=1
	else:
		card.scale=Vector2(1,1)
		card.z_index=0
		
	pass

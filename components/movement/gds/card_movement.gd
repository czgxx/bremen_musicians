extends Node2D
class_name CardMovement
const MAX_SPEED = 300.0
@export var enable:bool=false
var card:Card=null
var speed:float=300
enum STATE {IDEAL,MOVE,OVER}
var state:STATE=STATE.IDEAL
var diff:Vector2
var pos_src:Vector2
var pos_des:Vector2

func _init(enable:bool=true,name:String="CardMovement"):
	print("CardMoveMent setup： enable="+str(enable)+",name="+name)
	self.enable=enable
	self.name=name
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card=Global.check_parent_group(self,"Card")
	#get_card_size()
	#get_camera_view_rect()
	pass


func _physics_process(delta: float) -> void:
	if(card != null):
		move()
		#card.global_position=move_to(get_global_mouse_position())
	pass
#region 状态机
func state_machine():
	match state:
		STATE.IDEAL:
			if enable:
				state=STATE.MOVE
		STATE.MOVE:
			if pos_des==pos_src: 
				state=STATE.OVER
			pass
		STATE.OVER:
			state=STATE.IDEAL
			pass
	pass
#endregion
func update_state():
	#if state==STATE.MOVE:
		#card.card_data.state=CardData.STATE.MOVE
	#else:
		#card.card_data.state=CardData.STATE.IDEAL
	
	if state==STATE.OVER:
		enable=false
	pass
func move():
	state_machine()
	move_process()
	update_state()
@rpc("any_peer", "call_local", "reliable")
func move_to(to:Vector2):
	enable=true
	
	#pos_des=to
	if multiplayer.get_unique_id()==multiplayer.get_remote_sender_id():
		pos_des=to
	else:
		pos_des=-to
func move_process():
	var direction:Vector2
	#var from:Vector2=self.global_position
	
	var pos_inc:Vector2=Vector2.ZERO
	var result:Vector2=Vector2.ZERO
	if state==STATE.MOVE:
		pos_src=self.global_position
		diff=pos_des-pos_src
		direction=diff.normalized()
		pos_inc=direction*speed*get_physics_process_delta_time()
		if diff.length()>pos_inc.length():
			result=pos_src+pos_inc
			result=result.clamp(pos_des-card.card_data.card_size/2,pos_des+card.card_data.card_size/2)
			result=Global.limit_to_camera(result,card.card_data.card_size)
		else:
			result=pos_des
			
		card.global_position=result

	return result
	pass

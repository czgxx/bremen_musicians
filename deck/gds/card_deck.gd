extends Deck
class_name  CardDeck
var pos:Vector2=Vector2.ZERO
#var deck:Array[Card]
var current_camera:Camera2D
var step_camera_zoom=Vector2(0.05,0.05)
var max_cnt_wheel:int=3
var cnt_wheel:int=0:
	set(value):
		cnt_wheel=clamp(value,0,max_cnt_wheel)
enum STATE {IDEAL,PICK,HIDE,OVER}
var state:STATE=STATE.IDEAL
func state_machine():
	match state:
		STATE.IDEAL:
			if cnt_wheel>0:
				state=STATE.PICK
			pass
	pass
pass
func _init() -> void:
	pass
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		## 检查是否是滚轮事件
		#if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			#print("滚轮向上滚动")
			## 在这里执行放大、上一张牌等操作
			#zoom_in()
		#elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#print("滚轮向下滚动")
			## 在这里执行缩小、下一张牌等操作
			#zoom_out()
	#pass
func remove_card_from_hand(card:Card):
	if has_card(card):
		remove_card(card)
	pass
func add_card_to_hand(card:Card):
	if not has_card(card):
		add_card(card)
		card.card_state.auto_hover=false
	pass

func zoom_in():
	cnt_wheel=cnt_wheel+1
	if current_camera:
		current_camera.zoom+=step_camera_zoom
		current_camera.zoom=current_camera.zoom.clamp(Vector2(1,1)-step_camera_zoom*max_cnt_wheel,
													Vector2(1,1)+step_camera_zoom*max_cnt_wheel)
	print("cnt_wheel"+str(cnt_wheel))
func zoom_out():
	cnt_wheel=cnt_wheel-1
	if current_camera:
		current_camera.zoom-=step_camera_zoom
		current_camera.zoom=current_camera.zoom.clamp(Vector2(1,1)-step_camera_zoom*max_cnt_wheel,Vector2(1,1)+step_camera_zoom*max_cnt_wheel)
	print("cnt_wheel"+str(cnt_wheel))
func create_deck() -> void:
	spawn_deck(25)
	for card:Card in get_cards():
		add_child(card)
		card.move_to(self.global_position+card.get_index()*Vector2(1,1))
		card.card_data.is_face_up=false
		#i.card_high_light.enable=false
		#i.card_data.card_owner=self
		pass
	pass # Replace with function body.
func pick_card(card_index:int=get_cards().size()-1) -> Card:
	var card_picked:Card=get_cards()[card_index]
	print(card_picked.name+":is picked")
	card_picked.card_data.is_face_up=true
	SignalBus.deck_pick_card.emit(self,card_picked)
	remove_card(card_picked)
	cnt_wheel=0
	return card_picked
	pass

func hide_card(card_index:int=get_cards().size()-1) -> Card:
	var card_picked:Card=get_cards()[card_index]
	print(card_picked.name+":is hided")
	card_picked.card_data.is_face_up=false
	SignalBus.deck_hide_card.emit(self,card_picked)
	add_card(card_picked)
	cnt_wheel=0
	return card_picked
	pass
@rpc("any_peer", "call_local", "reliable")
func spawn_deck(num:int=52):
	for i in 13:
		for j in 3:
			#var card_new= CardManager.spawn_card(randi_range(3,17),randi_range(0,3))
			
			var card_new= CardManager.spawn_card(i,j)
			#print(card_new.card_data.card_name+"'s z_index :"+str(card_new.z_index))
			#card_new.global_position=pos
			add_card(card_new)
		pass
	pass
pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signalbus()
	create_deck()
	current_camera = get_viewport().get_camera_2d()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func connect_signalbus():
	SignalBus.card_area_mouse_wheel_down.connect(_on_card_area_mouse_wheel_down)
	SignalBus.card_area_mouse_wheel_up.connect(_on_card_area_mouse_wheel_up)
	pass

func _on_card_area_mouse_wheel_down(card:Card):
	if has_card(card):
		zoom_in()
		if cnt_wheel==max_cnt_wheel:
			pick_card()
	pass
func _on_card_area_mouse_wheel_up(card:Card):
	if has_card(card):
		zoom_out()
		if cnt_wheel==0:
			hide_card()
	pass

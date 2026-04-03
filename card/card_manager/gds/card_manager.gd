extends Node2D
#class_name CardManager

var card_mouse_on:Array[Card]=[]
static var card_max_z:Card
static var top_card_mouse_on:Card
static var card_moving:Card
static var card_highlighting:Card
static var card_all:Array[Card]=[]
var card_deck:CardDeck
var card_slot:CardSlot
var hand_player:Card
var max_z:int=0
enum STATE {IDEAL,HOVER_ON,MOVING}
var fsm:STATE=STATE.IDEAL
var is_mouse_pressed_card:bool
func _init() -> void:
	connect_signal_bus()
	#card_deck=CardDeck.new()
	#card_slot=CardSlot.new()
#func highlight_card(card:Card):
	#if fsm==STATE.HOVER_ON:
		#card_highlighting=top_card_mouse_on
	#elif fsm==STATE.IDEAL:
		#card_highlighting=null
	#
	#if card:
		#if fsm==STATE.HOVER_ON:
			#card.card_high_light.enable=true
			#card.card_shake.enable=true
			#for i in card_all:
				#if i!=card :
					#i.card_high_light.enable=false
					#i.card_shake.enable=false
				#pass
		#else:
			#card.card_high_light.enable=false
			#card.card_shake.enable=false
	#pass
#func move_card_to(card:Card,to:Vector2):
	#if fsm==STATE.HOVER_ON:
		#card_moving=top_card_mouse_on
	#elif fsm==STATE.IDEAL:
		#card_moving=null
		#
		#
	#if card:
		#if fsm==STATE.MOVING:
			##card.card_state.moving=true
			#card.move_to(to)
		#else:
			##card.card_state.moving=false
			#pass
	#pass
#func state_machine():
	#match fsm:
		#STATE.IDEAL:
			#if top_card_mouse_on:
				#fsm=STATE.HOVER_ON
			#pass
		#STATE.HOVER_ON:
			#if card_mouse_on.size()==0:
				#fsm=STATE.IDEAL
			#elif is_mouse_pressed_card==true:
				#fsm=STATE.MOVING
			#else:
				#fsm=STATE.HOVER_ON
			#pass
		#STATE.MOVING:
			#if is_mouse_pressed_card==false:
				#if card_mouse_on.size()==0:
					#fsm=STATE.IDEAL
				#else:
					#fsm=STATE.HOVER_ON
			#else :
				#fsm=STATE.MOVING
			#pass
	#pass

func _ready() -> void:
	#card_deck.spawn_deck(5)
	#for i in card_deck.deck:
		#add_child(i)
		#i.flip(1)
		
	#hand_model1()
	#card_model1()
	#card_model2()
	#card_model3()
	#card_model4()
	#card_slot_model1()
	#hand()
	pass
func _physics_process(delta: float) -> void:
	#state_machine()
	#highlight_card(card_highlighting)
	#move_card_to(card_moving,get_global_mouse_position())
	if top_card_mouse_on:
		#print("fsm="+str(top_card_mouse_on.card_state.highlighting))
		pass
	pass
#region card_model
#
#@rpc("any_peer", "call_local", "reliable")
#func hand_model1():
	#var card_new:Card=hand()
	#if card_new:
		#card_new.position=Vector2(200,200)
		#add_child(card_new)
	#pass
#@rpc("any_peer", "call_local", "reliable")
#func card_model1():
	#var card_new:Card= card(5,Global.CARD_COLOR.SPADE)
	#add_child(card_new)
	#card_new.global_position=Vector2(50,50)
	#pass
#@rpc("any_peer", "call_local", "reliable")
#func card_model2():
	#var card_new:Card=card(Vector2(50,70),10,Global.CARD_COLOR.HEART)
	#add_child(card_new)
	#pass
#@rpc("any_peer", "call_local", "reliable")
#func card_model3():
	#var card_new:Card=card(Vector2(50,90),11,Global.CARD_COLOR.CLUB)
#
	#add_child(card_new)
	#pass
#@rpc("any_peer", "call_local", "reliable")
#func card_model4():
	#var card_new:Card=card(Vector2(50,110),16,Global.CARD_COLOR.DIAMOND)
#
	#add_child(card_new)
	#pass
#@rpc("any_peer", "call_local", "reliable")
#func card_slot_model1():
	#
	#var card_new=card_slot(0,Global.CARD_COLOR.SLOT)
	#if card_new:
		#card_new.position=Vector2(100,80)
		#add_child(card_new)
	#pass
#endregion 
#region card_dectect
func get_card_max_z_index(cards:Array[Card])->Card:
	var card_max_z_index:Card
	var max_z_index:int
	#for i in cards:
		#print(i.name+"'s z_index"+str(i.z_index))
	if cards.size()>0:
		
		card_max_z_index=cards[0]
		max_z_index=card_max_z_index.z_index
		for i in cards:
			if i.z_index>max_z_index:
				card_max_z_index=i
				max_z_index=i.z_index
		if card_max_z_index:
			print(cards)
			
			print(card_max_z_index.name+" is the top_card,"+"in the "+str(card_mouse_on.size())+" the z_index is "+str(max_z_index))
	else:
		print("null under mouse")
	return card_max_z_index
	pass


#endregion
#region card_signal connect
#region connect card_signal to func
func connect_signal_bus():
	#area_2d signal 
	#if card.has_signal("area_entered"):
		#card.area_entered.connect(_on_card_area_entered)
	#if card.has_signal("area_exited"):
		#card.area_exited.connect(_on_card_area_exited)
	#if card.has_signal("input_event"):
		#card.input_event.connect(_on_card_input_event)
		
	#button signal 
	SignalBus.card_area_input_event.connect(_on_card_area_input_event)
	SignalBus.card_area_entered.connect(_on_card_area_entered)
	SignalBus.card_area_exited.connect(_on_card_area_exited)
	SignalBus.card_button_down.connect(_on_card_button_down)
	SignalBus.card_button_up.connect(_on_card_button_up)
	SignalBus.card_area_mouse_entered.connect(_on_card_area_mouse_entered)
	SignalBus.card_area_mouse_exited.connect(_on_card_area_mouse_exited)
	SignalBus.player_card_entered.connect(_on_player_card_entered)
	SignalBus.player_card_exited.connect(_on_player_card_exited)
	SignalBus.player_pick_card.connect(_on_player_pick_card)
	SignalBus.player_show_card.connect(_on_player_show_card)
	#if card.has_signal("mouse_entered"):
		#card.mouse_entered.connect(_on_card_mouse_entered)
	#if card.has_signal("mouse_exited"):
		#card.mouse_exited.connect(_on_card_mouse_exited)
	#print("_on_card_button_down")
	#if card.has_signal("button_down"):
		#card.button_down.connect(_on_card_button_down)
	#if card.has_signal("button_up"):
		#print("_on_button_button_up")
		#card.button_up.connect(_on_card_button_up)
	#if card.has_signal("pressed"):
		#card.pressed.connect(_on_card_pressed)
	#
	##timer signal 
	#if card.has_signal("timeout"):
		#card.timeout.connect(_on_card_timeout)
	#endregion
#region func connect_to card_signal
func _on_player_pick_card(player:Player):
	#print(player.name+" _on_player_pick_card ")
	#player.add_card(card_deck.pick_card())
	pass
func _on_player_show_card(player):
	#print(player.name+" _on_player_show_card ")
	pass
func _on_player_card_entered(player,card:Card):
	#print(card.name+" entered "+player.name)
	pass
func _on_player_card_exited(player,card:Card):
	#print(card.name +" exit "+player.name)
	pass
func _on_card_area_mouse_entered(card:Card):
	if card is Card:
		if card_mouse_on.has(card)==false:
			card_mouse_on.append(card)
			#print("entered:"+card.name)
		print(card_mouse_on)
		var top_card:Card=get_card_max_z_index(card_mouse_on)
		#for i in card_mouse_on:
			#print(i.name+"'s z_index"+str(i.z_index))
		if top_card_mouse_on!=top_card:
			top_card_mouse_on=top_card
			SignalBus.top_card_changed.emit(top_card_mouse_on)
		
		#print(top_card_mouse_on.z_index)
	pass
func _on_card_area_mouse_exited(card:Card):
	if card is Card:
		print(card_mouse_on)
		if card_mouse_on.has(card)==true:
			card_mouse_on.erase(card)
			print("exit:"+card.name)
		var top_card:Card=get_card_max_z_index(card_mouse_on)
		
		if top_card_mouse_on!=top_card:
			top_card_mouse_on=top_card
			SignalBus.top_card_changed.emit(top_card_mouse_on)
		
			#if top_card:
				#print("the top_card is "+top_card.name)
			#else:
				#print("no card be choosed")
	pass

func _on_card_area_input_event(card:Card, viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and card ==top_card_mouse_on:
		# 检查是否是滚轮事件
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			SignalBus.card_area_mouse_wheel_up.emit(card)
			print(self.name+":滚轮向上滚动")
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			SignalBus.card_area_mouse_wheel_down.emit(card)
			print(self.name+":滚轮向下滚动")
			
		if event.button_index == MOUSE_BUTTON_LEFT :
			SignalBus.card_area_mouse_left.emit(card)
			print(self.name+"左键被按下")
			# 在这里处理左键点击逻辑
		elif event.button_index == MOUSE_BUTTON_RIGHT :
			SignalBus.card_area_mouse_right.emit(card)
			print(self.name+"右键被按下")
	pass # Replace with function body.

func _on_card_area_entered(card:Card,area:Area2D):
	var card_entered:Card=area.find_parent("card*")
	if card and card_entered:
		#print(card_entered.name+" touch "+card.name)
		card.card_data.neighbor.append(card_entered)
		pass
	pass
func _on_card_area_exited(card:Card,area:Area2D):
	var card_exited:Card=area.find_parent("card*")
	if card and card_exited:
		#print(card_exited.name +" left " +card.name)
		card.card_data.neighbor.erase(card_exited)
	pass
func _on_card_input_event(card:Card):
	pass
func _on_card_button_down(card:Card):
	#print("_on_card_button_down")
	if card:
		if card.get_parent().is_in_group("Player"):
			SignalBus.card_player_select.emit(card)
		is_mouse_pressed_card=true
	pass
func _on_card_button_up(card:Card):
	#print("_on_button_button_up")
	if card:
		is_mouse_pressed_card=false
	pass
func _on_card_pressed(card:Card):
	pass
func _on_card_timeout(card:Card):
	pass
#endregion
#endregion

#region card_type
@rpc("any_peer", "call_local", "reliable")
static func spawn_card(parent:Node,num:CardData.NUM,suit:CardData.SUIT):
	var card:Card=Global.CARD.instantiate()
	parent.add_child(card)
	card.card_data.card_name="card_"+str(CardData.SUIT.keys()[suit])+str(num)
	card.card_data.card_num=num
	card.card_data.card_suit=suit
	card_all.append(card)
	return card
	pass

#endregion

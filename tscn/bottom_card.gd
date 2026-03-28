extends Node2D


@onready var color_rect: ColorRect = $ColorRect
@onready var text_edit: TextEdit = $TextEdit

var cards: Array[Card] = []
var container_rect: Rect2

func _physics_process(delta: float) -> void:
	pass
func _ready() -> void:
	color_rect.MOUSE_FILTER_IGNORE
	text_edit.MOUSE_FILTER_IGNORE
	connect_signal()
	# 获取容器区域（可以手动设置，或者从父节点获取）
	container_rect = Rect2(color_rect.global_position,color_rect.size)
	pass

func add_card(card:Card):
	SignalBus.player_show_card.emit(card)
	if card and container_rect.has_point(get_global_mouse_position())\
	and card.card_data.card_owner is Player:
		#print("丢弃手牌")
		cards.append(card)
		card.card_data.card_owner=self
		#card.reparent(self)
		#add_child(card)
		card.flip(1)
		#Player.rearrange_cards(cards,container_rect)
	else:
		#print("不在弃牌区")
		pass
		
func connect_signal():
	#SignalBus.player_pick_card.connect(_on_player_pick_card)
	#SignalBus.card_button_down.connect(_on_card_button_down)
	SignalBus.card_button_up.connect(add_card)
	#SignalBus.card_player_select.connect(_on_card_player_select)
	pass
#func is_mouse_inside():
	#return get_global_mouse_position().is
func _on_area_2d_mouse_entered() -> void:
	#print("mouse entered discard")
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	#print("mouse exited discard")
	pass # Replace with function body.

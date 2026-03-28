extends Node2D
class_name Player
var choose:bool
var move:bool

func _ready() -> void:
	connect_signal()
	# 获取容器区域（可以手动设置，或者从父节点获取）
	container_rect = Rect2(100, 100, 200, 200)
	#card_manager=CARD_MANAGER.instantiate()
	#add_child(card_manager)
	#var deck=card_manager.deck(10,Vector2.ZERO)
	#for i in deck:
		#add_child(i)
	pass

@export var max_cards: int = 10
@export var min_spacing: float = 20.0

var cards: Array[Card] = []
var container_rect: Rect2
func add_card(card:Card):
	if card:
		print("添加手牌")
		cards.append(card)
		card.card_data.card_owner=self
		#card.reparent(self)
		#add_child(card)
		card.flip(1)

func connect_signal():
	#SignalBus.player_pick_card.connect(_on_player_pick_card)
	SignalBus.player_show_card.connect(_on_player_show_card)
	SignalBus.card_button_down.connect(_on_card_button_down)
	SignalBus.card_button_up.connect(_on_card_button_up)
	SignalBus.card_player_select.connect(_on_card_player_select)
	pass
func _on_card_button_down(card:Card):
	
	if card:
		if card.card_data.card_owner==self:
			
			print(self.name+" click the "+card.name)
		pass
	pass
func _on_card_button_up(card:Card):
	#print(self.name+"_on_button_button_up")
	if card:
		if card.card_data.card_owner==self:
			
			print(self.name+" button_up "+card.name)
		pass
	pass
func _on_player_show_card(card:Card):
	pass
func _on_card_player_select(card:Card):
	print("select_card"+card.name)
	pass


	

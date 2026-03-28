class_name HandMoveCard
extends Deck
#extends Node2D
@onready var card_fan: CardFan = $CardFan
#var deck:Array[Card]=[]
var cnt_wheel:int=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signalbus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func connect_signalbus():
	SignalBus.card_area_mouse_right.connect(_on_card_area_mouse_right)
	SignalBus.card_area_mouse_left.connect(_on_card_area_mouse_left)
	SignalBus.card_area_mouse_wheel_down.connect(_on_card_area_mouse_wheel_down)
	SignalBus.card_area_mouse_wheel_up.connect(_on_card_area_mouse_wheel_up)
	SignalBus.deck_pick_card.connect(_on_deck_pick_card)
	SignalBus.deck_hide_card.connect(_on_deck_hide_card)
	SignalBus.player_pick_card.connect(_on_player_pick_card)
	#SignalBus.player_uncheck_card.connect(_on_player_uncheck_card)
	pass
func remove_card_from_deck(card:Card):
	if has_card(card):
		remove_card(card)
		card_fan.remove_card_from_deck(card)
	pass
func add_card_to_deck(card:Card):
	self.global_position=card.global_position+Vector2(0,-40)
	add_card(card)
	card_fan.add_card_to_deck(card)
	pass

func _on_player_pick_card(hand:Deck,card:Card):
	hand.remove_card_from_deck(card)
	add_card_to_deck(card)
	
	#card.move_to(card.global_position+Vector2(0,-20))
	pass
func _on_player_hide_card(hand:Deck,card:Card):
	
	pass
func _on_deck_pick_card(card_deck:CardDeck,card:Card):
	
	pass
func _on_deck_hide_card(card_deck:CardDeck,card:Card):
	if has_card(card):
		#deck.erase(card)
		#card_deck.deck.append(card)
		pass
func _on_card_area_mouse_wheel_down(card:Card):
	if has_card(card):
		
		if cnt_wheel>=1:
			cnt_wheel-=1
			for i in get_cards():
				i.move_to(i.global_position-Vector2(0,-10))
	pass
func _on_card_area_mouse_wheel_up(card:Card):
	if has_card(card):
		
		if cnt_wheel<=3:
			cnt_wheel+=1
			for i in get_cards():
				i.move_to(i.global_position+Vector2(0,-10))
		else:
			cnt_wheel=0
			SignalBus.player_show_card.emit(self,get_cards())
	pass

func _on_card_area_mouse_left(card:Card):
	pass
func _on_card_area_mouse_right(card:Card):
	SignalBus.player_uncheck_card.emit(self,card)
	
	pass

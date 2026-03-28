extends Deck

var is_mouse_on:bool

@onready var color_rect: ColorRect = $ColorRect
@onready var card_fan: CardFan = $CardFan

var cards: Array[Card] = []
var container_rect: Rect2

func _ready() -> void:
	color_rect.MOUSE_FILTER_IGNORE
	connect_signal()
	container_rect = Rect2(color_rect.global_position,color_rect.size)
	pass
func remove_card_from_deck(card:Card):
	if has_card(card):
		remove_card(card)
		card_fan.remove_card_from_deck(card)
	pass
	
func add_card_to_deck(card:Card):
	add_card(card)
	card_fan.add_card_to_deck(card)
	pass
func connect_signal():
	SignalBus.player_show_card.connect(_on_player_show_card)
	#SignalBus.card_button_up.connect(add_card)
	#SignalBus.card_player_select.connect(_on_card_player_select)
	pass
func _on_player_show_card(hand:Deck,deck:Array) -> void:
	#print(deck)
	for card in deck:
		hand.remove_card_from_deck(card)
		add_card_to_deck(card)
	pass # Replace with function body.

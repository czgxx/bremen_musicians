class_name HandHoldCard
extends Deck
#extends Node2D
@onready var card_spade: CardFan = $CardSpade
@onready var card_heart: CardFan = $CardHeart
@onready var card_club: CardFan = $CardClub
@onready var card_diamond: CardFan = $CardDiamond
@onready var card_main: CardFan = $CardMain

#var deck:Array[Card]=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signalbus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func connect_signalbus():
	SignalBus.card_area_mouse_left.connect(_on_card_area_mouse_left)
	SignalBus.card_area_mouse_wheel_down.connect(_on_card_area_mouse_wheel_down)
	SignalBus.card_area_mouse_wheel_up.connect(_on_card_area_mouse_wheel_up)
	SignalBus.card_button_pressed.connect(_on_card_button_pressed)
	SignalBus.card_button_down.connect(_on_card_button_down)
	SignalBus.card_button_up.connect(_on_card_button_up)
	SignalBus.deck_pick_card.connect(_on_deck_pick_card)
	SignalBus.deck_hide_card.connect(_on_deck_hide_card)
	SignalBus.player_uncheck_card.connect(_on_player_uncheck_card)
	pass
func remove_card_from_deck(card:Card):
	if has_card(card):
		#remove_card(card)
		match card.card_face.card_suit:
			card.CardFace.SUIT.SPADE:
				print("SPADE")
				card_spade.remove_card_from_deck(card)
			card.CardFace.SUIT.HEART:
				print("HEART")
				card_heart.remove_card_from_deck(card)
			card.CardFace.SUIT.CLUB:
				print("CLUB")
				card_club.remove_card_from_deck(card)
			card.CardFace.SUIT.DIAMOND:
				print("DIAMOND")
				card_diamond.remove_card_from_deck(card)
	
	pass
func add_card_to_deck(card:Card):
	if not has_card(card):
		#add_card(card)
		card.card_state.auto_hover=true
		#card.card_high_light.enable=true
		match card.card_face.card_suit:
			card.CardFace.SUIT.SPADE:
				print("SPADE")
				card_spade.add_card_to_deck(card)
			card.CardFace.SUIT.HEART:
				print("HEART")
				card_heart.add_card_to_deck(card)
			card.CardFace.SUIT.CLUB:
				print("CLUB")
				card_club.add_card_to_deck(card)
			card.CardFace.SUIT.DIAMOND:
				print("DIAMOND")
				card_diamond.add_card_to_deck(card)
	pass

func _on_player_uncheck_card(hand:Deck,card:Card):
	#if has_card(card):
		#deck.append(card)
	print("_on_player_uncheck_card")
	hand.remove_card_from_deck(card)
	add_card_to_deck(card)
	
	#card.move_to(card.global_position+Vector2(0,20))
	pass
func _on_deck_pick_card(card_deck:CardDeck,card:Card):
	#if has_card(card):
		#deck.append(card)
	add_card_to_deck(card)
	#card_deck.deck.erase(card)
	pass
func _on_deck_hide_card(card_deck:CardDeck,card:Card):
	if has_card(card):
		#deck.erase(card)
		#card_deck.deck.append(card)
		pass
func _on_card_area_mouse_wheel_down(card:Card):
	if has_card(card):
		pass
	pass
func _on_card_area_mouse_wheel_up(card:Card):
	if has_card(card):
		pass
	pass
func _on_card_button_pressed(card:Card):
	#print("_on_card_button_pressed")
	if card:
		if has_card(card):
			#card.move_to(Vector2(200,200))
			#remove_child(card)
			pass
	pass
func _on_card_button_down(card:Card):
	if card:
		if has_card(card):
			#print(self.name+"_on_card_button_down")
			#print(deck)
			##card.card_flip.is_face_up=true
			##remove_child(card)
			#SignalBus.player_pick_card.emit(self,card)
			pass
	pass
func _on_card_button_up(card:Card):
	#print("_on_button_button_up")
	if card:
		if has_card(card):
			pass
		pass
	pass
func _on_card_area_mouse_left(card:Card):
	if card_spade.has_card(card) or \
	card_club.has_card(card) or\
	card_diamond.has_card(card) or\
	card_heart.has_card(card) or\
	card_main.has_card(card) :
		#print(self.name+"_on_card_button_down")
		#print(deck)
		SignalBus.player_pick_card.emit(self,card)
	pass

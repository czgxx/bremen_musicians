extends Node2D

@onready var card_manager: CardManager = $CardManager
#var set_test:set=_set_1
#func _set_1(value):
	#set_test=value
	
func _on_button_button_down() -> void:
	card_manager.card_deck.spawn_deck(5)
	for i in card_manager.card_deck.deck:
		add_child(i)
		#i.flip(1)
	pass # Replace with function body.

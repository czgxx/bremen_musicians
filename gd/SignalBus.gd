extends Node


# ===== 卡牌相关信号 =====
signal card_created(card_node, card_data)
signal card_destroyed(card_id)
signal card_selected(card_node)
signal card_deselected(card_node)
signal card_played(card_node, target)
signal card_drawn(player_id, card_node)
signal card_shuffled(deck_array)

signal top_card_changed(card_node)
signal card_area_input_event(card_node, viewport, event, shape_idx)
signal card_area_mouse_left(card_node)
signal card_area_mouse_right(card_node)
signal card_area_mouse_wheel_up(card_node)
signal card_area_mouse_wheel_down(card_node)
signal card_area_mouse_entered(card_node)
signal card_area_mouse_exited(card_node)
signal card_tree_entered(card_node)
signal card_tree_exited(card_node)
signal card_button_down(card_node)
signal card_button_up(card_node)
signal card_button_pressed(card_node)
signal card_area_entered(card_node,area_2d)
signal card_area_exited(card_node,area_2d)
signal deck_pick_card(deck,card)
signal deck_hide_card(deck,card)
signal player_card_entered(card_node,area_2d)
signal player_card_exited(card_node,area_2d)
signal player_pick_card(player,card)
signal player_uncheck_card(player,deck)
signal player_hide_card(player,deck)
signal player_show_card(player,deck)
signal card_player_select(card)
# ===== 玩家相关信号 =====
signal player_joined(player_id)
signal player_left(player_id)
signal turn_started(player_id)
signal turn_ended(player_id)
signal turn_timer_updated(time_left)

# ===== 游戏状态信号 =====
signal game_started
signal game_paused(is_paused)
signal game_ended(winner_id)
signal score_updated(player_id, new_score)

# ===== UI 信号 =====
signal ui_button_pressed(button_name)
signal ui_panel_opened(panel_name)
signal ui_panel_closed(panel_name)
signal notification_shown(message, type)

# ===== 网络信号 =====
signal network_connected(peer_id)
signal network_disconnected(peer_id)
signal network_data_received(data, from_id)
##region area_2d signal
#signal area_entered
#signal area_exited
#signal input_event
#func _on_area_2d_mouse_entered() -> void:
	##print("hovered on")
	#card_data.is_mouse_on=true
	#pass # Replace with function body.
#
#func _on_area_2d_mouse_exited() -> void:
	##print("hovered off")
	#card_data.is_mouse_on=false
	#pass # Replace with function body.
#
#func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#emit_signal("input_event",self,viewport, event, shape_idx)
	#pass # Replace with function body.
#
#func _on_area_2d_area_entered(area: Area2D) -> void:
	#emit_signal("area_entered",self,area)
	##print(card_enter.name)
	#pass # Replace with function body.
#
#func _on_area_2d_area_exited(area: Area2D) -> void:
#
	#emit_signal("area_exited",self,area)
	##print(card_exit.name)
	#pass # Replace with function body.
##endregion
##region timer signal
#signal timeout
#func _on_timer_timeout() -> void:
	#emit_signal("timeout",self)
	##shaking=false
	##print("timer stop")
	##sprite_2d.global_rotation_degrees=0
	##sprite_2d_2.global_rotation_degrees=0
	##timer.stop()
	#pass # Replace with function body.
##endregion
##region button signal
#signal button_down
#signal button_up
#signal pressed
#signal mouse_entered
#signal mouse_exited
#func _on_button_pressed() -> void:
	#emit_signal("pressed",self)
	##shaking=true
	##timer.start(1)
	#pass # Replace with function body.
#
#func _on_button_button_up() -> void:
	#print("_on_button_button_up")
	#emit_signal("button_up",self)
	#pass # Replace with function body.
#
#
#func _on_button_button_down() -> void:
	#emit_signal("button_down",self)
	##print("_on_button_button_up")
	#pass # Replace with function body.
#
#
#func _on_button_toggled(toggled_on: bool) -> void:
	#pass # Replace with function body.
	#
#
#func _on_button_mouse_entered() -> void:
	#card_data.is_mouse_on=true
	#emit_signal("mouse_entered",self)
	#pass # Replace with function body.
#
#
#func _on_button_mouse_exited() -> void:
	#card_data.is_mouse_on=false
	#emit_signal("mouse_exited",self)
	#pass # Replace with function body.
##endregion

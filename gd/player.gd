extends Node2D
var my_player_id = 1  # 需要在连接时设置

func _ready():
# 连接时获取自己的ID
	my_player_id = multiplayer.get_unique_id()

# 点击牌堆抽牌
#func _on_deck_pressed():
## 调用 RPC 请求抽牌
	#request_draw_card.rpc(my_player_id)
#
## 点击手牌中的某张牌
#func _on_card_pressed(card_id):
	#request_play_card.rpc(my_player_id, card_id)
#
## 点击洗牌按钮
#func _on_shuffle_button_pressed():
## 只有服务器可以洗牌
	#if multiplayer.is_server():
		#request_shuffle.rpc()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

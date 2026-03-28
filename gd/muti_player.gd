extends Control

const  PORT=235
const SERVER_ADDRESS="192.168.1.89"
const CARD_MANAGER = preload("uid://bdhojpdntu48j")
signal player_joined(player_id)
signal player_left(player_id)

var players: Dictionary = {}  # key: player_id, value: player_data
var player_count: int = 0

@onready var card_manager: CardManager = $"../CardManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta: float) -> void:
	pass
func _on_master_pressed() -> void:

	var peer=ENetMultiplayerPeer.new()
	peer.create_server(PORT,4)
	multiplayer.multiplayer_peer=peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_connected.disconnect(_on_peer_disconnected)
	#if multiplayer.is_server():
		#add_child(card_manager)
	#Global.setup_fullscreen_for_instance()
	#var new_card_table=CARD_MANAGER.instantiate()
	#add_child(new_card_table)
	print("服务器已启动，等待玩家连接...")
	pass # Replace with function body.


func _on_slaver_pressed() -> void:
	var peer=ENetMultiplayerPeer.new()
	peer.create_client(SERVER_ADDRESS,PORT)
	multiplayer.multiplayer_peer=peer
	# 连接信号，获知连接结果
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	#add_child(card_manager)
	#Global.setup_fullscreen_for_instance()
	pass # Replace with function body.


func _on_card_pressed() -> void:
	#Global.setup_fullscreen_for_instance()
	if multiplayer.is_server():
		card_manager.card_model1.rpc()
		card_manager.card_slot_model1.rpc()
	pass # Replace with function body.
func _on_peer_disconnected(id):
	remove_player(id)
	print("Player: "+id+" has left!")
	pass
func _on_peer_connected(id):
	add_player(id)
	if multiplayer.is_server():
		test_rpc.rpc()
	pass
func add_player(id: int):
	if not players.has(id):
		players[id] = {
			"id": id,
			"name": "Player_" + str(id),
			"join_time": Time.get_ticks_msec(),
			"is_server": id == 1  # 通常服务器ID是1
		}
		player_count = players.size()
		player_joined.emit(id)
		
		# 广播给所有客户端
		if multiplayer.is_server():
			rpc("sync_player_list", players)
func remove_player(id: int):
	if players.erase(id):
		player_count = players.size()
		player_left.emit(id)
		
		if multiplayer.is_server():
			rpc("sync_player_list", players)

@rpc("reliable")
func sync_player_list(new_players: Dictionary):
	players = new_players
	player_count = players.size()
	print("玩家列表已同步: ", players.keys())

# 获取所有玩家ID
func get_all_player_ids() -> Array:
	return players.keys()

# 获取玩家数量
func get_player_count() -> int:
	return players.size()

# 检查是否所有玩家都准备好了
func are_all_players_ready() -> bool:
	# 你的准备逻辑
	return true
@rpc("any_peer", "reliable")
func test_rpc():
	print("--------------------------------------------------")
	print("RPC 被调用，当前时间: ", Time.get_ticks_msec())
	print("调用者ID: ", multiplayer.get_remote_sender_id())
	print("执行者ID: ", multiplayer.get_unique_id())
	print("--------------------------------------------------")


func _on_connected_to_server():
	print("成功连接到服务器！我的ID是：", multiplayer.get_unique_id())

func _on_connection_failed():
	print("连接服务器失败。")

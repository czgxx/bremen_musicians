extends Node

const MAX_JOIN=4
const  PORT=1000
#const SERVER_ADDRESS="192.168.1.89"
const SERVER_ADDRESS="192.168.0.103"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 根据身份自动开始网络连接
	_auto_start_network()
	pass # Replace with function body.

func _auto_start_network():
	# 再次检查命令行参数，但这次是为了启动网络连接
	var cmdline_args = OS.get_cmdline_args()
	var is_server = false
	for arg in cmdline_args:
		if arg == "--server":
			is_server = true
			break

	# 根据身份自动执行网络逻辑
	if is_server:
		_start_as_server()
	else:
		# 客户端启动时，给一点延迟确保服务器已经完全启动
		await get_tree().create_timer(0.5).timeout
		_start_as_client()


func _start_as_server():
	print("自动以服务器模式启动")
	var peer = ENetMultiplayerPeer.new()
	# 使用之前协商好的端口
	var error = peer.create_server(PORT, MAX_JOIN) 
	if error != OK:
		print("服务器创建失败: ", error)
		return
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_connected.disconnect(_on_peer_disconnected)
	# 这里可以添加服务器初始化逻辑，比如初始化牌堆
	# ... 

func _start_as_client():
	print("自动以客户端模式连接服务器")
	var peer = ENetMultiplayerPeer.new()
	# 连接到本地服务器
	var error = peer.create_client(SERVER_ADDRESS, PORT) 
	if error != OK:
		print("客户端创建失败: ", error)
		return
	else:
		print("客户端创建成功！")
	multiplayer.multiplayer_peer = peer
	# 这里可以添加连接成功后的逻辑
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)

func _on_peer_disconnected(id):
	print("Player: "+id+" has left!")
	pass
func _on_peer_connected(id):
	if multiplayer.is_server():
		test_rpc.rpc()
	pass
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

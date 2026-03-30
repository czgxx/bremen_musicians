extends Node2D

const CARD = preload("res://card/top/scenes/card.tscn")
const card_size:Vector2=Vector2(32,48)
const card_offset:Vector2=Vector2(2,2)
var choosing_card:bool
var moving_card:bool
var top_card:Card
var card_group_name:String="Card"
enum CardType {NORM,SLOT,DECK}
enum CARD_COLOR {SPADE,HEART,CLUB,DIAMOND,SLOT}
const CARD_COLOR_NAME={
	CARD_COLOR.SPADE:"SPADE",
	CARD_COLOR.HEART:"HEART",
	CARD_COLOR.CLUB:"CLUB",
	CARD_COLOR.DIAMOND:"DIAMOND",
	CARD_COLOR.SLOT:"SLOT"
}
var CARD_IMAGE:Array=[]
var sprites_root_path="res://sprites/"

var camera:Camera2D
var screen_size:Vector2
const WINDOW_WIDTH = 1280
const WINDOW_HEIGHT = 720
static var view_rect:Rect2
static var screen_center :Vector2=Vector2.ZERO
static var view_size :Vector2=Vector2.ZERO
var mouse_in_window:bool

@onready var main: Node2D = $"."
func _init() -> void:
	#get_window().size = Vector2i(1152, 648)

	
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 等待一帧，确保窗口系统完全初始化
	
	_diagnose_window()
	_setup_window()
	# 根据身份自动开始网络连接
	#_auto_start_network()
	var current_camera = get_viewport().get_camera_2d()
	camera = get_current_camera()
	camera = current_camera
	screen_size=main.get_viewport_rect().size

func get_current_camera() -> Camera2D:
	# 获取当前场景的根节点
	var current_scene = get_tree().current_scene
	if not current_scene:
		print("没有当前场景")
		return null
	
	# 从根节点查找 Camera2D
	var camera = current_scene.find_child("Camera2D", true, false)
	if camera:
		return camera
	else:
		# 或者通过视口获取当前活动的摄像机
		var viewport_camera = get_viewport().get_camera_2d()
		if viewport_camera:
			return viewport_camera
		else:
			print("没有找到 Camera2D")
			return null
func _diagnose_window():
	var window = get_window()
	if not window:
		print("无法获取窗口")
		return
	
	print("\n=== 窗口诊断报告 ===")
	print("窗口标题: ", window.title)
	print("窗口大小: ", window.size)
	print("窗口位置: ", window.position)
	print("窗口模式: ", window.mode)
	print("窗口可见: ", window.visible)
	print("窗口最小化: ", window.mode == Window.MODE_MINIMIZED)
	print("窗口最大化: ", window.mode == Window.MODE_MAXIMIZED)
	print("窗口全屏: ", window.mode == Window.MODE_FULLSCREEN)
	print("是否有边框: ", not window.borderless)
	print("窗口ID: ", get_window().get_window_id())
	# 检查是否嵌入在编辑器中
	print("是否嵌入编辑器: ", Engine.is_embedded_in_editor())
	print("===================\n")
	
	# 尝试修改
	print("尝试修改窗口属性...")
	
	window.title = "诊断窗口 - " + str(Time.get_ticks_msec())
	print("标题修改结果: ", window.title)
	
	var old_size = window.size
	window.size = Vector2i(800, 600)
	await get_tree().process_frame
	print("大小修改结果: ", old_size, " -> ", window.size)
	
	var old_pos = window.position
	window.position = Vector2i(200, 200)
	await get_tree().process_frame
	print("位置修改结果: ", old_pos, " -> ", window.position)
func _draw():
	# 绘制摄像机视野边框（调试用）
	view_rect= get_camera_view_rect()
	print(view_rect)
	draw_rect(view_rect, Color.GREEN, false, 2.0)
# 获取当前视口（屏幕）的尺寸
func get_viewport_size() -> Vector2:
	return get_viewport().get_visible_rect().size

# 考虑摄像机缩放的实际视野尺寸
func get_camera_view_size() -> Vector2:
	var viewport_size = get_viewport().get_visible_rect().size
	var zoom = camera.zoom  # 摄像机的缩放值
	
	# 实际视野大小 = 视口大小 / 缩放
	var actual_view_size = viewport_size / zoom
	
	return actual_view_size

func get_camera_view_rect() -> Rect2:
	# 函数体内的代码使用Tab缩进
	if camera:
		screen_center = camera.get_screen_center_position()
		view_size = get_viewport().get_visible_rect().size / camera.zoom
	
	return Rect2(
		screen_center - view_size / 2,
		view_size
	)
static func limit_to_camera(pos:Vector2,size:Vector2)->Vector2:
	if not Global.camera:
		return pos
	
	# 获取卡牌尺寸（假设是 Sprite2D）
	#var card_size = card_image.get_card_size()
	#var view_rect = get_camera_view_rect()
	
	# 计算边界（确保卡牌完整显示）
	var min_x = view_rect.position.x + size.x / 2
	var max_x = view_rect.end.x - size.x / 2
	var min_y = view_rect.position.y + size.y / 2
	var max_y = view_rect.end.y - size.y / 2
	var result:Vector2
	# 限制位置
	result.x = clamp(pos.x, min_x, max_x)
	result.y = clamp(pos.y, min_y, max_y)
	return result
func _setup_window():
	var window = get_window()
	#
	await get_tree().process_frame
	await get_tree().process_frame
	# 1. 统一窗口大小
	window.size = Vector2i(WINDOW_WIDTH, WINDOW_HEIGHT)
	#DisplayServer.window_set_size(Vector2i(WINDOW_WIDTH, WINDOW_HEIGHT))
	# 2. 根据实例类型设置位置
	var is_server = false
	var is_client = false
	var screen_size = DisplayServer.screen_get_size()
	var num_client:int=0
	var cmdline_args = OS.get_cmdline_args()
	for arg in cmdline_args:
		print("arg is ",arg)
	for arg in cmdline_args:
		if arg == "--server":
			is_server = true
			break
		elif arg == "--client":
			is_client = true
			num_client+=1
			

	if is_server:
		if num_client==0:
		# 服务器窗口靠中
			window.position = Vector2i(850, 550)
			window.mode = Window.MODE_WINDOWED
			pass
		else:
		# 服务器窗口靠左
			window.position = Vector2i(50, 250)
			window.mode = Window.MODE_WINDOWED
	elif is_client:
		# 客户端窗口靠右（不重叠）
		# 客户端窗口：放在服务器窗口的右边，确保两个窗口不重叠
		var client_x = 50 + WINDOW_WIDTH + 50
		# 做个简单的安全检查：如果计算出的位置加上窗口宽度会超出屏幕，就把它放回屏幕左边
		if client_x + WINDOW_WIDTH > screen_size.x:
			client_x = 50
		window.position = Vector2i(client_x, 250)
		window.mode = Window.MODE_WINDOWED
		print("客户端窗口位置已设为: ", window.position)
	
	# 3. 固定窗口（可选）
	window.borderless = false  # 设为 true 可以去掉边框
	window.always_on_top = false
	
	# 4. 打印调试信息
	print("窗口设置完成 - 大小: ", window.size, " 位置: ", window.position)
	print("是服务器: ", is_server)
	window.title = "纸牌游戏 - " + ("服务器" if is_server else "客户端")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func check_parent_group(child:Node2D,group:String):
	#print_debug("来自: ", child.name,child.get_parent().name)
	if(child.get_parent().is_in_group(group)):
		#print(child.name+"is ready!")
		return child.get_parent()
	else:
		#print("error: "+child.name+" not under the "+group)
		return null
	pass
#region limit_to_camera


#func get_camera_view_rect() -> Rect2:
	#var screen_center = Global.camera.get_screen_center_position()
	#var view_size = get_viewport().get_visible_rect().size / Global.camera.zoom
	#
	#return Rect2(
		#screen_center - view_size / 2,
		#view_size
	#)


#endregion
static func find_parent_in_group(node: Node, group: String) -> Node:
	var parent = node.get_parent()
	while parent:
		if parent.is_in_group(group):
			return parent
		parent = parent.get_parent()
	return null
static func print_czg(message):
	var msg:String=str(message)
	if msg:
		print(msg)

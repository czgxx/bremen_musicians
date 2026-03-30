extends AnimationPlayer
class_name CardAnimation
var wheel_cnt:int=0
var card:Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 为这张卡牌创建独立的动画副本
	_create_unique_animation("move")
	card=Global.find_parent_in_group(self,"Card")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


var _animation_initialized: bool = false

func _create_unique_animation(anim_name: String):
	if _animation_initialized:
		return
	
	#var anim_name = "move"
	var original_anim = get_animation(anim_name)
	
	if original_anim:
		# 复制动画资源
		var unique_anim = original_anim.duplicate()
		
		# 创建新库并添加动画
		var new_lib = AnimationLibrary.new()
		new_lib.add_animation(anim_name+"_unique", unique_anim)
		add_animation_library("card_unique", new_lib)
		# 替换原有的动画（同名会覆盖）
		#add_animation(anim_name, unique_anim)
		
		_animation_initialized = true
		print("卡牌 ", name, " 动画已独立")


func modify_keyframe_value(anim_name: String, track_index: int, key_index: int, new_value):
	# 确保动画已独立
	if not _animation_initialized:
		_create_unique_animation(anim_name)
	var animation = get_animation(anim_name)
	if not animation:
		return
	
	# 获取关键帧的值（需要知道轨道类型）
	var track_type = animation.track_get_type(track_index)
	
	match track_type:
		Animation.TYPE_VALUE:  # 值轨道（属性变化）
			var current = animation.track_get_key_value(track_index, key_index)
			animation.track_set_key_value(track_index, key_index, new_value)
			print("关键帧值从 ", current, " 改为 ", new_value)
		
		Animation.TYPE_BEZIER:  # 贝塞尔曲线轨道
			var point = animation.track_get_key_value(track_index, key_index)
			point.value = new_value
			animation.track_set_key_value(track_index, key_index, point)

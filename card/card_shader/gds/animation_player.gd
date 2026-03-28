extends AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.
var wheel_cnt:int=0
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed :
		# 检查是否是滚轮事件
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			
			if wheel_cnt==2:
				wheel_cnt=0
			elif wheel_cnt==1:
				play_section_with_markers("card_flip","little_peek","end")
			elif wheel_cnt==0:
				play_section_with_markers("card_flip","start","little_peek")
			wheel_cnt+=1
			print(self.name+":滚轮向上滚动")
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if wheel_cnt==2:
				play_section_with_markers_backwards("card_flip","little_peek","end")
			elif wheel_cnt==1:
				play_section_with_markers_backwards("card_flip","start","little_peek")
			elif wheel_cnt==0:
				wheel_cnt=0
			wheel_cnt-=1
			
			print(self.name+":滚轮向下滚动")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

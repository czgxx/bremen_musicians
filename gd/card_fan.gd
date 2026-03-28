extends Deck
class_name CardFan
@export var step_width:float = 5.0
@export var HAND_WIDTH=200
@export var HAND_HIGHT=8
#@export var get_cards():Array[Card]
@export var spread_x_curve:Curve
@export var spread_y_curve: Curve

# 在编辑器里把创建好的曲线资源拖拽到这个变量上
@export var fan_curve: Curve
# 牌的起始和最终角度
@export var step_angle:float = 2.0
@export var start_angle: float = -30.0
@export var end_angle: float = 30.0

var tween: Tween
func add_card_to_deck(card:Card):
	if not has_card(card):
		#add_child(card)
		
		card.reparent(self)
		add_card(card)
		print(self.name+" add_card:"+card.name)
		print(self.name+" deck :"+str(get_cards().size()))
		#print(get_cards())
		#card.move_to(Vector2(200,200))
		show_cards()
		#fan_out_cards(get_cards())
func remove_card_from_deck(card:Card):
	if has_card(card):
		remove_card(card)
		show_cards()
		#fan_out_cards(get_cards())
func show_cards():
	for i in get_cards().size():
		var card:Card = get_cards()[i]
		# 计算这个卡牌在整个扇形中的理想位置
		var hand_radio:float=0.5
		if get_cards().size()<52:
			HAND_WIDTH=get_cards().size()*8
		if get_cards().size()>1:
			hand_radio=float(card.get_index()-1)/float(get_cards().size()-1)
			
		card.move_to(self.global_position+ Vector2(spread_x_curve.sample(hand_radio)*HAND_WIDTH,-spread_y_curve.sample(hand_radio)*HAND_HIGHT))
		#print(card.get_index())
		
	pass
# 执行扇形展开动画
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#fan_out_cards(get_children())
	pass
	#await tween.is_running()==false
	#calcu_pos(get_children())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#calcu_pos()
	pass

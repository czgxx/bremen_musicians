extends Resource
class_name CardData

@export_category("📋 基础信息")
@export var card_name: String:
	set(value):
		card_name=value
		changed.emit("card_name",value,card_name)

# ========== 卡片尺寸 ==========
@export_category("📐 卡片尺寸")
@export var card_size: Vector2 = Vector2(64, 96):
	set(value):
		card_size=value
		card_front.card_size=value
		card_back.card_size=value

enum NUM {N3=3,N4,N5,N6,N7,N8,N9,N10,Nj,Nq,Nk,Na,N2,Ng,NG}
@export var card_num:NUM=NUM.N3:
	set(value):
		card_num=clampi(value,NUM.N3,NUM.NG)
		changed.emit("card_num",value,card_num)

enum SUIT {SPADE,HEART,CLUB,DIAMOND}
@export var card_suit:SUIT=SUIT.SPADE:
	set(value):
		card_suit=value
		changed.emit("card_suit",value,card_suit)
@export var card_front:CardImageData= CardImageData.new():
	set(value):
		changed.emit("card_front",value,card_front)
		card_front=value
@export var card_back:CardImageData= CardImageData.new():
	set(value):
		changed.emit("card_back",value,card_back)
		card_back=value
#@export var card_image:Dictionary={
	#"front" = CardImageData.new(),
	#"back"  = CardImageData.new(),
#}
var neighbor:Array[Card]
var neighbor_left:Array[Card]
var neighbor_right:Array[Card]
func add_neighbor(card:Card):
	neighbor.append(card)
	changed.emit("neighbor",neighbor,neighbor)
func remove_neighbor(card:Card):
	neighbor.erase(card)
	changed.emit("neighbor",neighbor,neighbor)
var is_top_card:bool=false
var is_face_up:bool=true
var is_on_table:bool=true
enum LOCALTION {TABLE,HAND,}
enum STATE {IDEAL,HOVER_ON,MOVE,}
signal state_changed
var state:STATE=STATE.IDEAL:
	set(value):
		if state!=value:
			state_changed.emit(state,value)
			state=value

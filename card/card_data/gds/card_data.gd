extends Resource
class_name CardData

@export_category("📋 基础信息")
@export var card_name: String:
	set(value):
		card_name=value
		changed.emit("card_name",value,card_name)


@export var card_num:int:
	set(value):
		card_num=clampi(value,3,17)

enum SUIT {SPADE,HEART,CLUB,DIAMOND}
@export var card_suit:SUIT
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
var is_top_card:bool=false
var is_face_up:bool=true
enum STATE {IDEAL,HOVER_ON,MOVE,}
var state:STATE=STATE.IDEAL

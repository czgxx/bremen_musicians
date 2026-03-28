@abstract
class_name Deck
extends Node2D
var _deck:Array[Card]
# 获取只读副本
func get_cards() -> Array:
	return _deck.duplicate()

# 增加元素
func add_card(card: Card) -> void:
	if card in _deck:
		return
	
	_deck.append(card)
	print("➕ 卡牌加入: ", card.name)
	print("当前手牌数量: ", _deck.size())
	
	# 触发加入时的逻辑
	on_card_added(card)
	#update_ui()
func on_card_added(card:Card):
	sort_cards_by_z_index()
	pass
# 按 z_index 从小到大排序（数字越大越靠上）
func sort_cards_by_z_index():
	#_deck.sort_custom(func(a, b): return a.z_index < b.z_index)
	
	# 按顺序重新赋值
	for i in range(_deck.size()):
		_deck[i].z_index = i
	for card:Card in _deck:
		card.name=(card.card_face.SUIT.keys()[card.card_data.card_suit]+
		str(card.card_data.card_num)+"+z_index="+
		str(card.z_index)
		)
# 移除元素
func remove_card(card: Card) -> bool:
	if card not in _deck:
		return false
	
	_deck.erase(card)
	sort_cards_by_z_index()
	print("➖ 卡牌移除: ", card.name)
	print("剩余手牌: ", _deck.size())
	
	# 触发移除时的逻辑
	#on_card_removed(card)
	#update_ui()
	return true

func on_card_removed(card:Card):
	sort_cards_by_z_index()
	pass
# 批量增加
func add_cards(new_cards: Array[Card]) -> void:
	for card in new_cards:
		if card not in _deck:
			_deck.append(card)
			print("➕ 加入: ", card.name)
	
	print("批量加入完成，总数: ", _deck.size())
	#update_ui()

func has_card(card:Card):
	if _deck.has(card):
		return true
	else:
		return false
	pass

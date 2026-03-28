extends Resource
class_name LabelData
var name:String
var text:String:
	set(value):
		text=value
		changed.emit("text",value,text)
		pass
var transform:Transform2D:
	set(value):
		transform=value
		changed.emit("transform",value,transform)
		pass

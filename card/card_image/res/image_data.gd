extends Resource
class_name ImageData
var name:String
var texture:Texture:
	set(value):
		texture=value
		changed.emit("texture",value,texture)
		pass
var transform:Transform2D:
	set(value):
		transform=value
		changed.emit("transform",value,transform)
		pass

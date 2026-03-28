extends HBoxContainer


func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("hhhhhhh")
	if area.find_parent("card*"):
		#print("???????")
		area.find_parent("card*").reparent(self)
		print(area.find_parent("card*").name +" has got")
	pass # Replace with function body.


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.

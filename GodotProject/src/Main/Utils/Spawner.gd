extends Position2D


func _on_Timer_timeout():
	var box = preload("res://src/Obstacles/Box/Box.tscn").instance()
	box.position = position
	get_parent().add_child(box)

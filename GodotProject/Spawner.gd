extends Position2D
class_name Spawner

var spawning: bool = true

func _on_Timer_timeout():
	if not spawning: return
	
	var box = preload("res://src/Obstacles/Box/Box.tscn").instance()
	box.position = position
	get_parent().add_child(box)

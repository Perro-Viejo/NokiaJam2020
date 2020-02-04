extends Position2D
class_name Spawner

var spawning: bool = true
var enemy_types: Array = [
	load("res://src/Characters/Enemies/Wolf/Wolf.tscn"),
	load("res://src/Characters/Enemies/Cat/Cat.tscn"),
	load("res://src/Characters/Enemies/Penguin/Penguin.tscn")
]


func _on_Timer_timeout():
	if not spawning: return
	
	# Elegir un enemigo al azar y parirlo
	enemy_types.shuffle()
	var enemy = enemy_types[0].instance()

	enemy.position = position
	get_parent().add_child(enemy)

extends Node2D

func _input(event):
	if event is InputEventKey and event.pressed:
		get_parent().get_tree().change_scene_to(load("res://src/TitleScreen/TitleScreen.tscn"))

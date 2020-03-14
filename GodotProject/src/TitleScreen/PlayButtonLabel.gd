extends 'res://src/TitleScreen/MainMenuButton.gd'

func excecute_command():
	get_parent().get_tree().change_scene_to(load('res://src/Levels/Level1/Level1.tscn'))
	

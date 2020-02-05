extends Node2D


func _ready():
	EventsManager.connect("play_requested", self, "_on_play_requested")
	
	
func _on_play_requested(source, sound):
	get_node(""+source+"/"+sound).play()

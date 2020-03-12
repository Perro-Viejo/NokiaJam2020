extends Node2D

func _ready() -> void:
	# Conectar señales
	EventsManager.connect("possum_alerted", self, "_on_possum_alerted")
	EventsManager.connect("enemy_left", self, "_on_enemy_left")
	EventsManager.connect("possum_awake", self, "_on_possum_awake")
	add_child(load("res://src/GUI/GUI.tscn").instance())
	add_child(load("res://src/Main/Managers/AudioManager.tscn").instance())


func _on_possum_alerted() -> void:
	$Background/AnimationPlayer.stop(false)
	for spawner in $Spawners.get_children():
		var _spawner: Spawner = spawner as Spawner
		if _spawner:
			_spawner.spawning = false


func _on_enemy_left() -> void:
	
	for spawner in $Spawners.get_children():
		var _spawner: Spawner = spawner as Spawner
		if _spawner:
			_spawner.spawning = true

func _on_possum_awake() ->void:
	$Background/AnimationPlayer.play("Loop")

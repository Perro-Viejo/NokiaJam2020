extends Node2D

func _ready() -> void:
	# Conectar señales
	EventsManager.connect("possum_alerted", self, "_on_possum_alerted")


func _on_possum_alerted() -> void:
	$Background/AnimationPlayer.stop(false)
	for spawner in $Spawners.get_children():
		var _spawner: Spawner = spawner as Spawner
		if _spawner:
			_spawner.spawning = false
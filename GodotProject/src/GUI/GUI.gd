extends CanvasLayer

func _ready() -> void:
	# Conectar señales
	EventsManager.connect("possum_pretended", self, "_on_possum_alerted")
	EventsManager.connect("enemy_left", self, "_on_enemy_left")
	
	# Establecer estado por defecto de la escena
	$Control.hide()


func _on_possum_alerted() -> void:
	$Control.show()


func _on_enemy_left() -> void:
	$Control.hide()

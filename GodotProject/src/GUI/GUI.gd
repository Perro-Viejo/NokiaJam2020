extends CanvasLayer

func _ready() -> void:
	# Conectar señales
	EventsManager.connect("possum_pretended", self, "_on_possum_alerted")
	
	# Establecer estado por defecto de la escena
	$Control.hide()


func _on_possum_alerted() -> void:
	$Control.show()

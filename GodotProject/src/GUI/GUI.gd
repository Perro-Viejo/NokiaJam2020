extends CanvasLayer

func _ready() -> void:
	# Conectar señales
# warning-ignore:return_value_discarded
	EventsManager.connect('possum_pretended', self, '_on_possum_alerted')
# warning-ignore:return_value_discarded
	EventsManager.connect('enemy_approached', self, '_on_enemy_approached')
# warning-ignore:return_value_discarded
	EventsManager.connect('enemy_left', self, '_on_enemy_left')
	
	EventsManager.connect('item_picked', self, '_on_item_picked')
	
	# Establecer estado por defecto de la escena
	$Control.hide()


func _on_possum_alerted() -> void:
	$Control.show()


func _on_enemy_approached(smell_time: int) -> void:
	$Control/RightPanel/Number.start()
	$Control/LeftPanel/CenterContainer/SmellBar.start(smell_time)


func _on_enemy_left() -> void:
	$Control.hide()
	
func _on_item_picked(count) -> void:
	$AnimationPlayer.play("ShowCounter")
	$FruitCount.count_fruit(count)
	print('he recogido la suma cantidad de ', count)
	
	

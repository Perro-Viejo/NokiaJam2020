extends CanvasLayer
class_name GUI
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
onready var _left_panel: Panel = $Control/LeftPanel
onready var _right_panel: Panel = $Control/RightPanel
onready var _smell_bar: TextureProgress = $Control/LeftPanel/CenterContainer/SmellBar
onready var _bite: Panel = $Control/Bite
onready var _lose: Panel = $Control/Lose
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	# Conectar señales
# warning-ignore:return_value_discarded
	EventsManager.connect('possum_pretended', self, '_on_possum_alerted')
# warning-ignore:return_value_discarded
	EventsManager.connect('enemy_approached', self, '_on_enemy_approached')
# warning-ignore:return_value_discarded
	EventsManager.connect('enemy_left', self, '_on_enemy_left')
# warning-ignore:return_value_discarded
	EventsManager.connect('item_picked', self, '_on_item_picked')
# warning-ignore:return_value_discarded
	EventsManager.connect('possum_discovered', self, '_on_possum_discovered')
# warning-ignore:return_value_discarded
	EventsManager.connect('level_finished', self, '_on_level_finished')
	
	# Establecer estado por defecto de la escena
	$Control.hide()
	_bite.hide()
	_lose.hide()
	
	# Cargar valores del nivel
	$FruitCount.fruit_limit = get_parent().fruit_goal


func _on_possum_alerted() -> void:
	$Control.show()


func _on_enemy_approached(smell_time: int) -> void:
	$Control/RightPanel/Number.start()
	_smell_bar.start(smell_time)


func _on_enemy_left() -> void:
	$Control.hide()
	
func _on_item_picked(count) -> void:
	$AnimationPlayer.play("ShowCounter")
	$FruitCount.count_fruit(count)


func _on_possum_discovered() -> void:
	_smell_bar.stop()
	_left_panel.hide()
	_right_panel.hide()


func _on_level_finished(type: String) -> void:
	if (type == EventsManager.FINISH_TYPE.DEFEAT):
		# TODO: Que los paneles se oculten con una animación
		_bite.show()
		var bite_animator: AnimationPlayer = _bite.get_node('AnimationPlayer')
		bite_animator.play('Close', -1.0, 2.0)
		yield(bite_animator, 'animation_finished')
		yield(get_tree().create_timer(1), 'timeout')
		_lose.show()
	else:
		$Victory.show()
		yield(get_tree().create_timer(1.3), "timeout")
		$Victory/Presionameste.show()

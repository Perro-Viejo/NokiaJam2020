class_name GUI
extends CanvasLayer
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
enum TestType { NONE, WIN, LOSE, MINIGAME }

export(TestType) var test = TestType.NONE

onready var _left_panel: Panel = $Control/LeftPanel
onready var _right_panel: Panel = $Control/RightPanel
onready var _smell_bar: TextureProgress = $Control/LeftPanel/CenterContainer/SmellBar
onready var _bite: Panel = $Control/Bite
onready var _lose: Panel = $Control/Lose
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
"""
Esta función se llamará antes que el _ready() pues es invocada por el nivel
cuando se crea una instancia de GUI. Por eso la usamos para resetear el valor
que sea que tenga la variable 'test'.
"""
func initialize(fruit_goal: int) -> void:
	# Cargar valores del nivel
	$FruitCount.fruit_limit = fruit_goal
	
	# Reemplazar el valor de test para que no funcione cuando se ejecute el
	# juego desde la escena principal
	test = TestType.NONE


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
	
	# Ver si se quiere probar algo cuando se corra la escena sola
	if test != TestType.NONE:
		$Control.show()
		
		match test:
			TestType.LOSE:
				_on_possum_discovered()
				_on_level_finished(EventsManager.FINISH_TYPE.DEFEAT)
			TestType.WIN:
				self._on_level_finished(EventsManager.FINISH_TYPE.VICTORY)


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
		EventsManager.emit_signal('play_requested', 'MX', 'Bite')
		
		yield(bite_animator, 'animation_finished')
		yield(get_tree().create_timer(1), 'timeout')
		
		_lose.show()
		yield(get_tree().create_timer(0.4), 'timeout')
		EventsManager.emit_signal('play_requested', 'MX', 'Lose')
	else:
		$Victory.show()
		EventsManager.emit_signal('play_requested', 'UI', 'Win')
		yield(get_tree().create_timer(1), "timeout")
		$Victory/Presionameste.show()
		EventsManager.emit_signal('play_requested', 'UI', 'Sub')
		yield(get_tree().create_timer(0.5), "timeout")
		EventsManager.emit_signal('play_requested', 'MX', 'Win')

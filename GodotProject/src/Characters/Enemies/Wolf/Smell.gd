extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Wolf = owner as Wolf
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	_owner.get_node('Detector/CollisionShape2D').disabled = true
	_owner.get_node('Sprite/AnimationPlayer').play('Smell')
	EventsManager.emit_signal('enemy_approached', _owner.smell_time)

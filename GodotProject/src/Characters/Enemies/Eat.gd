extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Enemy = owner as Enemy
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	yield(get_tree().create_timer(0.5), 'timeout')
	_owner.animator.play('Eat')
	yield(_owner.animator, 'animation_finished')
	print('Me la comí y estuvo rico rico rcio')
	EventsManager.emit_signal(
		'level_finished',
		EventsManager.FINISH_TYPE.DEFEAT
	)

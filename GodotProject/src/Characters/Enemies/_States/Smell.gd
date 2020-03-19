extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Enemy = owner as Enemy
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	
	_owner.get_node('Detector/CollisionShape2D').disabled = true
	_owner.animator.play('Smell')
	
	# Conectar señales
	EventsManager.connect(
		'possum_discovered',
		_state_machine,
		'transition_to',
		[_owner.STATES.EAT]
	)
	
	# Emitir señales
	EventsManager.emit_signal('enemy_approached', _owner.smell_time)


func exit() -> void:
	.exit()
	_owner.animator.stop()
	EventsManager.disconnect(
		'possum_discovered',
		_state_machine,
		'transition_to'
	)

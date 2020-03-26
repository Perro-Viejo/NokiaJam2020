extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Enemy = owner as Enemy
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	
	_owner.set_z_index(0)
	_owner.animator.play('Smell')
	
	_owner.detector_collision.disabled = true
	
	# Conectar señales
	EventsManager.connect(
		'possum_discovered',
		_state_machine,
		'transition_to',
		[_owner.STATES.EAT]
	)
	EventsManager.connect('possum_done', self, '_on_possum_done')
	
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
	EventsManager.disconnect('possum_done', self, '_on_possum_done')


func _on_possum_done() -> void:
	_owner.set_z_index(4)
	
	# Que no tenga hambre para que se pueda ir del nivel ignorando a la Runcha
	_owner.hungry = false
	_state_machine.transition_to(_owner.STATES.WALK, { 'leave': true })

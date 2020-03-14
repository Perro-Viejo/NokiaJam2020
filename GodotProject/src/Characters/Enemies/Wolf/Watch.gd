extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var approach_tick: int = 4
var tick: int = 0
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Wolf = owner as Wolf
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	tick = 0
	EventsManager.emit_signal('possum_alerted')


func world_tick() -> void:
	tick += 1
	if tick == approach_tick:
		tick = 0
		_state_machine.transition_to(_owner.STATES.WALK, { 'run': true })

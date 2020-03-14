extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var change_tick: int = 2
var tick: int = 0
var step: int = 0
var last_frame: int = 8
var y_by_step: Dictionary = {
	1: 3,
	2: 4,
	3: 7,
	4: 5
}
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Wolf = owner as Wolf
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	tick = 0
	step = 0
	
	# Ver bajo qué condiciones va a funcionar el estado
	if msg.has('run') and msg.run:
		change_tick = 1
		_owner.collision_shape.disabled = false
	else:
		change_tick = 2
		_owner.collision_shape.disabled = true


func world_tick() -> void:
	tick += 1
	if tick == change_tick:
		tick = 0
		step += 1
		
		# Retroalimentación de EJ (aka UX)
		_owner.sprite.frame = min(last_frame, _owner.sprite.frame + 1) as int
		EventsManager.emit_signal('play_requested', _owner.get_name(), 'Walk')
		
		if y_by_step.has(step): _owner.position.y += y_by_step[step]
		else: _owner.position.y += 5

	if not _owner.collision_shape.disabled:
		if _owner.check_collision() == 'Opossum':
			_state_machine.transition_to(_owner.STATES.SMELL)
	else:
		# Ver si ya se está en el frame en el que se ve a la Runcha
		if _owner.sprite.frame == _owner.visibility_frame:
			_state_machine.transition_to(_owner.STATES.WATCH)

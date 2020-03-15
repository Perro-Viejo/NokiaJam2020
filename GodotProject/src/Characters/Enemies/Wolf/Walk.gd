extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var change_tick: int = 1
var tick: int = 0
var step: int = 0
var last_frame: int = 7
var y_by_step: Dictionary = {
	1: 3,
	2: 5,
	3: 9,
	4: 13
}
var running: bool = false
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Wolf = owner as Wolf
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	tick = 0
	step = 0
	running = false
	
	_owner.collision_shape.disabled = false
	
	if msg.has('run') and msg.run:
		running = true


func world_tick() -> void:
	tick += 1
	
	if tick >= change_tick:
		tick = 0
		step += 1
		
		# Ver si ya se está en el frame en el que se ve a la Runcha
		if _owner.hungry and not running \
			and _owner.sprite.frame >= _owner.visibility_frame:
			_state_machine.transition_to(_owner.STATES.WATCH)
			return

		if running:
			var target: String = _owner.check_collision()
			
			if _owner.hungry and target == 'Opossum':
				_state_machine.transition_to(_owner.STATES.SMELL)
				return
			elif target == 'Bounds':
				_state_machine.transition_to(_owner.STATES.DISAPPEAR)
				return
		
		# Retroalimentación de EJ (aka UX)
		_owner.sprite.frame = min(last_frame, _owner.sprite.frame + 1) as int
		EventsManager.emit_signal('play_requested', _owner.get_name(), 'Walk')
		
		# Desplazar al lobo
		if y_by_step.has(step): _owner.position.y += y_by_step[step]
		else: _owner.position.y += 18

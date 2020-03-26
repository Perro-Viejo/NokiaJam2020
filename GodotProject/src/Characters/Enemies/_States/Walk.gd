extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
export(int) var change_z_on = 0

var _change_tick: int = 2
var _tick: int = 0
var _step: int = 0
var _last_frame: int = 7
var _y_by_step: Dictionary = {
	1: 3,
	2: 6,
	5: 24,
	6: 40
}
var _running: bool = false

# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Enemy = owner as Enemy
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	_tick = 0
	_change_tick = 2
	_running = false
	
	_owner.collision_shape.disabled = true
	_owner.detector_collision.disabled = false
	
	if msg.has('run') and msg.run:
		_running = true
		_owner.collision_shape.disabled = false
		_change_tick = 1


func world_tick() -> void:
	_tick += 1
	
	if _tick >= _change_tick:
		_tick = 0
		_step += 1
		
		# Ver si ya se está en el frame en el que se ve a la Runcha
		if _owner.hungry and not _running \
			and _owner.sprite.frame >= _owner.visibility_frame:
			_state_machine.transition_to(_owner.STATES.WATCH)
			return

		var target: String = _owner.check_collision()
		
		if _running and _owner.hungry and target == 'Opossum':
			_state_machine.transition_to(_owner.STATES.SMELL)
			return
		elif target == 'Bounds':
			_state_machine.transition_to(_owner.STATES.DISAPPEAR)
			return
		
		# Retroalimentación de EJ (Experiencia del Jugador, o UX para las locas)
		_owner.sprite.frame = min(_last_frame, _owner.sprite.frame + 1) as int
		
		EventsManager.emit_signal('play_requested', _owner.get_name(), 'Walk')
		
		# Desplazar al enemigo
		if _running: _owner.position.y += _owner.y_run_speed
		elif _y_by_step.has(_step): _owner.position.y += _y_by_step[_step]
		else: _owner.position.y += _owner.y_speed
		
		# Ver si hay que actualizar el z-index
		if _running and change_z_on == _owner.sprite.frame:
			_owner.set_z_index(4)

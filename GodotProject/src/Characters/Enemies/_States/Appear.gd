extends 'res://src/Main/StateMachine/State.gd'
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var change_tick: int = 2
var tick: int = 0
var step: int = 0
var last_frame: int = 3
var y_by_step: Dictionary = {
	2: 1,
	3: 1
}
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Enemy = owner as Enemy
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	_owner.collision_shape.disabled = true
	_owner.show()


func world_tick() -> void:
	tick += 1
	if tick == change_tick:
		tick = 0
		step += 1
		_owner.sprite.frame = min(last_frame, _owner.sprite.frame + 1) as int
		if y_by_step.has(step):
			_owner.position.y += y_by_step[step]
		if _owner.sprite.frame == last_frame:
			_state_machine.transition_to(_owner.STATES.WALK)

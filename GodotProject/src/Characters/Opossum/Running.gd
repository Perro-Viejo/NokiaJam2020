extends 'res://src/Main/StateMachine/State.gd'
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var step_tick = 1
var tick_count: int = 0

onready var _owner: Opossum = owner as Opossum
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	owner.play_animation(owner.STATES.RUNNING, _state_machine._previous_state)


func physics_process(delta) -> void:
	owner.velocity.x = (Input.get_action_strength('move_right') - \
		Input.get_action_strength('move_left')) * 10


func world_tick():
	tick_count += 1
	
	if tick_count == step_tick:
		tick_count = 0
		_owner.play_walk()

	_owner._sprite.frame = wrapi(_owner._sprite.frame + 1, 0, 4)

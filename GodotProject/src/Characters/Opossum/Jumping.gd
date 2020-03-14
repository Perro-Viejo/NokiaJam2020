extends 'res://src/Main/StateMachine/State.gd'

func _physics_process(delta):
	if owner.velocity.y > 0.0:
		if not owner.is_on_floor():
			_state_machine.transition_to(owner.STATES.FALLING, { 'jump_interrupted': false })


func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	owner.play_animation(owner.STATES.RUNNING, _state_machine._previous_state)
	

	owner.velocity.y = -20

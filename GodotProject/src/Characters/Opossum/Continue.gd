extends 'res://src/Main/StateMachine/State.gd'

func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	owner.play_animation(owner.STATES.CONTINUE, _state_machine._previous_state)


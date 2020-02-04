extends "res://src/Main/StateMachine/State.gd"

func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	owner.play_animation(owner.STATES.RUNNING, _state_machine._previous_state)


func physics_process(delta) -> void:
	owner.velocity.x = (Input.get_action_strength("move_right") - \
		Input.get_action_strength("move_left")) * 10

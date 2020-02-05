extends "res://src/Main/StateMachine/State.gd"


func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	owner.velocity.x = 0
	owner.get_node("Sprite/Alert").show()
	owner.play_animation(owner.STATES.ALERT, _state_machine._previous_state)
	yield(get_tree().create_timer(1), "timeout")
	_state_machine.transition_to(owner.STATES.PLAY_POSSUM)


func exit() -> void:
	.exit()
	owner.get_node("Sprite/Alert").hide()

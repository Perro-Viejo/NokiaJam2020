extends 'res://src/Main/StateMachine/State.gd'

func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	owner.play_animation(owner.STATES.PLAY_POSSUM, _state_machine._previous_state)
	yield(owner.get_node('Sprite/AnimationPlayer'), 'animation_finished')
	EventsManager.emit_signal('possum_pretended')

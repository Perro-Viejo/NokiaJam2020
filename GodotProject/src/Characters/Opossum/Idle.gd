extends "res://src/Main/StateMachine/State.gd"

func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
	EventsManager.connect(
		"level_started",
		_state_machine,
		"transition_to",
		[owner.STATES.RUNNING]
	)

func exit() -> void:
	.exit()
	EventsManager.disconnect("level_started", _state_machine, "transition_to")

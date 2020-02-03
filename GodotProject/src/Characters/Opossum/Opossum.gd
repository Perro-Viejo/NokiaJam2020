extends "res://src/Characters/Actor.gd"

const STATES = {
	RUNNING = "Running",
	ALERT = "Alert",
	PLAY_POSSUM = "PlayPossum"
}

func _ready() -> void:
	# Conectar señales
	EventsManager.connect("possum_alerted", self, "_on_possum_alerted")
	
	# Establecer estado por defecto de algunas mierdas
	$Sprite/Alert.hide()


func play_animation(code, previous_state = ""):
	match code:
		STATES.RUNNING:
			$Sprite/AnimationPlayer.play("Running", -1, 5)
		STATES.ALERT:
			$Sprite/AnimationPlayer.play("Alert")
		STATES.PLAY_POSSUM:
			$Sprite/AnimationPlayer.play("PlayPossum", -1, 2.0)


func _on_possum_alerted():
	$StateMachine.transition_to(STATES.ALERT)
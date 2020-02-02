extends KinematicBody2D

const STATES = { 
	RUNNING="Running",
	PRETENDING_DEATH="PretendingDeath"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play_animation(code, previous_state = ""):
	match code:
		STATES.RUNNING:
			$Sprite/AnimationPlayer.play("Running", -1, 5)
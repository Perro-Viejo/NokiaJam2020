extends "res://src/Characters/Actor.gd"

const STATES = {
	RUNNING="Running",
	PRETENDING_DEATH="PretendingDeath",
	FALLING="Falling",
	JUMPING="Jumping"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta) -> void:
	velocity.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * 10
	
func _input(event: InputEvent):
	
	if is_on_floor() and event.is_action_pressed("jump"):
		jump()

func jump():
	$StateMachine.transition_to(STATES.JUMPING, {})
	
func play_animation(code, previous_state = ""):
	match code:
		STATES.RUNNING:
			$Sprite/AnimationPlayer.play("Running", -1, 5)

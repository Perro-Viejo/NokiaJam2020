extends KinematicBody2D

var velocity = Vector2.ZERO

func _physics_process(delta):
	
	move_and_slide(velocity)

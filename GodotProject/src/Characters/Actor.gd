extends KinematicBody2D

var velocity = Vector2.ZERO
var max_velocity = Vector2(10, 20)
var gravity = 0
const FLOOR_NORMAL: = Vector2.UP

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if velocity.x > max_velocity.x:
		velocity.x = max_velocity.x
	
	if velocity.y > max_velocity.y:
		velocity.y = max_velocity.y
	
	move_and_slide(velocity, FLOOR_NORMAL)

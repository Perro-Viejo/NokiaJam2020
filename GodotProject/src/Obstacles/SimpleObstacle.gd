extends KinematicBody2D

export(int) var visibility_depth = -1
export(int) var speed = 1
export(Vector2) var distance = Vector2.ONE

var passed_time: = 0.0
var done_steps: int = 0


func _physics_process(delta):
	passed_time += delta
	
	if int(passed_time) == speed:
		passed_time = 0.0
		position += distance

		if visibility_depth >= 0 and done_steps == visibility_depth:
			print("Esa gonorrea ya me puede ver")
			EventsManager.emit_signal("possum_alerted")

		done_steps += 1

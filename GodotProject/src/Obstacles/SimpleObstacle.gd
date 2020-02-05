extends KinematicBody2D
class_name SimpleObstacle

export(int) var visibility_depth = -1
export(int) var speed = 1
export(int) var y_distance = 0
export(int) var collision_steps = 0

var passed_time: = 0.0
var done_steps: int = 0
var distance: Vector2 = Vector2.ZERO
var show_steps = 0
var walk_steps = 0

func _ready() -> void:
	distance.y = y_distance

func _physics_process(delta):
	passed_time += delta
	
	if passed_time >= 1 / speed:
		passed_time = 0.0
		done_steps += 1
		print("%s hizo ya %d pasos" % [ get_name(), done_steps ])

		if visibility_depth >= 0 and done_steps == visibility_depth:
			EventsManager.emit_signal("possum_alerted")

		if done_steps <= show_steps:
			play_show()
		else:
			position += distance
			
			if done_steps <= walk_steps:
				play_walk()
			
			if done_steps >= collision_steps:
				check_collision()


func check_collision():
	if $CollisionShape2D.disabled:
		$CollisionShape2D.disabled = false
	else:
		var bodies = $Detector.get_overlapping_bodies()
	
		for body in bodies:
			if (body.name == "Bounds" or body.name == "Opossum"):
				get_parent().remove_child(self)
				self.queue_free()

func play_show():
	pass
	
func play_walk():
	pass
	
func play_smell():
	pass

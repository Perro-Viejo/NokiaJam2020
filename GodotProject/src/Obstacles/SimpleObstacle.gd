extends KinematicBody2D
class_name SimpleObstacle

export(int) var visibility_depth = -1
export(int) var speed = 1
export(int) var y_distance = 0
export(int) var collision_steps = 0
export(int) var smell_time = 0

var passed_time: = 0.0
var done_steps: int = 0
var distance: Vector2 = Vector2.ZERO
var show_steps: int = 0
var walk_steps: int = 0
var smelling: bool = false
var leaving: bool = false

func _ready() -> void:
	distance.y = y_distance
	
	# Conectar señales
	EventsManager.connect('possum_done', self, '_on_possum_done')

func _physics_process(delta):
	passed_time += delta
	
	if passed_time >= 1 / speed:
		passed_time = 0.0
		done_steps += 1
		print("%s hizo ya %d pasos" % [ get_name(), done_steps ])

		if visibility_depth >= 0 and done_steps == visibility_depth:
			EventsManager.emit_signal("possum_alerted")
			distance.y += 2

		if done_steps <= show_steps:
			play_show()
		elif not smelling:
			position += distance
			
			if not leaving and done_steps <= walk_steps:
				play_walk()
			
			if not leaving and done_steps >= collision_steps:
				check_collision()
				
			if leaving:
				var bodies = $Detector.get_overlapping_bodies()
	
				for body in bodies:
					if body.name == "Bounds":
						leave_world()


func check_collision():
	if $CollisionShape2D.disabled:
		$CollisionShape2D.disabled = false
	else:
		var bodies = $Detector.get_overlapping_bodies()
	
		for body in bodies:
			if body.name == "Bounds":
				leave_world()
			elif body.name == "Opossum":
				play_smell()


func leave_world():
	EventsManager.emit_signal("enemy_left")
	get_parent().remove_child(self)
	self.queue_free()


func play_show():
	pass
	
func play_walk():
	pass
	
func play_smell():
	pass

func _on_possum_done():
	pass

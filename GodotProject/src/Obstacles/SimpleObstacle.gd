extends KinematicBody2D
class_name SimpleObstacle

export(int) var visibility_depth = -1
export(int) var speed = 1
export(int) var y_distance = 0

var passed_time: = 0.0
var done_steps: int = 0
var distance: Vector2 = Vector2.ZERO

func _ready() -> void:
	distance.y = y_distance

func _physics_process(delta):
	passed_time += delta
	
	if int(passed_time) == speed:
		passed_time = 0.0
		position += distance

		if visibility_depth >= 0 and done_steps == visibility_depth:
			print("Esa gonorrea ya me puede ver")
			EventsManager.emit_signal("possum_alerted")

		done_steps += 1
	
	if $Sprite.frame == 3 and $CollisionShape2D.disabled:
		$CollisionShape2D.disabled = false

	var bodies = $Detector.get_overlapping_bodies()

	for body in bodies:
		if not $CollisionShape2D.disabled and \
			(body.name == "Opossum" || body.name == "Bounds"):
			match body.name:
				"Opossum":
					print("¡Ay vida hijueputa! me pegué en la pata!")
				"Bounds":
					print("Adiós adiocín, se despide un obstaculín")
			get_parent().remove_child(self)
			self.queue_free()

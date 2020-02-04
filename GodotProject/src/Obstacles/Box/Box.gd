extends "res://src/Obstacles/SimpleObstacle.gd"

func _ready():
	$CollisionShape2D.disabled = true


func _physics_process(delta):
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

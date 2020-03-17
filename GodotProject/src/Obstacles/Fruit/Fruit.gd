extends 'res://src/Obstacles/SimpleObstacle.gd'
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
export(int) var collision_frame = 3
export(int) var y_speed = 2
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready():
	$CollisionShape2D.disabled = true


func _on_world_moved() -> void:
	show()
	
	position.y += y_speed
	
	if $Sprite.frame == collision_frame:
		$CollisionShape2D.disabled = false

	if not $CollisionShape2D.disabled:
		var bodies = $Detector.get_overlapping_bodies()
		if bodies.size() > 1:
			match bodies[0].name:
				'Opossum':
					print('¡Ay vida hijueputa! me pegué en la pata!')
				'Bounds':
					print('Adiós adiocín, se despide un obstaculín')
			EventsManager.emit_signal('object_left')
			get_parent().remove_child(self)
			self.queue_free()

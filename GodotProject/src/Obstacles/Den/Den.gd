extends 'res://src/Obstacles/SimpleObstacle.gd'
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
export(int) var collision_frame = 3

var can_move = true


#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready():
	$CollisionShape2D.disabled = true


func _on_world_moved() -> void:
	show()
	
	if can_move:
		position.y += y_speed
	
	if $Sprite.frame == collision_frame:
		$CollisionShape2D.disabled = false

	if not $CollisionShape2D.disabled:
		var bodies = $Detector.get_overlapping_bodies()
		if bodies.size() > 1:
			match bodies[0].name:
				'Opossum':
					bodies[0].pickup_fruit()
				'Bounds':
					print('Adiós adiocín, se despide un obstaculín')
			EventsManager.emit_signal('object_left')
			get_parent().remove_child(self)
			self.queue_free()

func stop_moving():
	can_move = false

func approach_sfx():
		EventsManager.emit_signal('play_requested', 'UI', 'Den')


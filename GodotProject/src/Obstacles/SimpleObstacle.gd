extends KinematicBody2D
class_name SimpleObstacle
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
export(int) var visibility_frame = 0
export(bool) var hungry = true
export(int) var smell_time = 0

var distance: Vector2 = Vector2.ZERO
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	hide()
	
	# Conectar señales
	EventsManager.connect('world_advanced', self, '_on_world_moved')
	EventsManager.connect('possum_done', self, '_on_possum_done')


func _on_world_moved() -> void:
	pass


func check_collision() -> String:
	var bodies = $Detector.get_overlapping_bodies()
	if bodies.size() > 0:
		return bodies[0].name
	return ''


func _on_possum_done() -> void:
	pass

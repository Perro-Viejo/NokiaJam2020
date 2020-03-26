extends KinematicBody2D
class_name SimpleObstacle
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
export(int) var y_speed = 2

var distance: Vector2 = Vector2.ZERO

#var _y_by_step: Dictionary = {
#	0: 0,
#	2: 1, # A partir del paso 2 bajar 1 un Y
#
#	# 0 se ve a la distancia
#	# 17 ya desaparece
#}
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	hide()
	
	# Conectar señales
	EventsManager.connect('world_tick', self, '_on_world_moved')
#	EventsManager.connect('world_advanced', self, '_on_world_moved')
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

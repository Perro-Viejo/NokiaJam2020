extends KinematicBody2D
class_name SimpleObstacle
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
export(int) var visibility_frame = 0
export(int) var speed = 1
export(int) var y_distance = 0
export(int) var collision_steps = 0
export(int) var smell_time = 0
export(int) var watch_ticks = 0

var passed_time: = 0.0
var done_steps: int = 0
var distance: Vector2 = Vector2.ZERO
var show_steps: int = 0
var walk_steps: int = 0
var smelling: bool = false
var leaving: bool = false
var appearing: bool = true
var watching: bool = false
var walking: bool = false
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	hide()
	
	distance.y = y_distance
	
	# Conectar señales
	EventsManager.connect('world_advanced', self, '_on_world_moved')
	EventsManager.connect('possum_done', self, '_on_possum_done')


func _on_world_moved() -> void:
	pass


func check_collision() -> String:
	var bodies = $Detector.get_overlapping_bodies()
	if bodies.size() > 0:
		return bodies[0].name

#	for body in bodies:
#		if body.name == 'Bounds':
#			leave_world()
#		elif body.name == 'Opossum':
#			play_smell()
	return ''


func leave_world() -> void:
	EventsManager.emit_signal('enemy_left')
	get_parent().remove_child(self)
	self.queue_free()

func play_show() -> void:
	pass

func start_walk() -> void:
	walking = true

func play_walk() -> void:
	pass
	
func play_smell() -> void:
	pass

func _on_possum_done() -> void:
	pass

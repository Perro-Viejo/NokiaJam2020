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
	EventsManager.connect("world_advanced", self, '_on_world_moved')
	EventsManager.connect('possum_done', self, '_on_possum_done')


func _on_world_moved() -> void:
	show()
	
	done_steps += 1
	
	if appearing:
		if done_steps <= show_steps:
			play_show()
		else:
			appearing = false
			start_walk()
	elif not smelling:
#		position += distance

		if walking:
			if done_steps <= walk_steps:
				play_walk()
			if done_steps >= collision_steps:
				check_collision()
		if leaving:
			var bodies = $Detector.get_overlapping_bodies()

			for body in bodies:
				if body.name == "Bounds":
					leave_world()

	if not watching and visibility_frame == $Sprite.frame:
		watching = true
		
		EventsManager.emit_signal("possum_alerted")
		# TODO: Aumentar la velocidad del enemigo como si etuviera afanado por
		# llegar donde su posible presa
		distance.y = 0
	elif watching:
		watch_ticks -= 1
		if watch_ticks <= 0:
			# Después de que el enemigo mire un rato a la Runcha, se acercará a
			# ella.
			print('Voy a ver si está muerta esa gonorrea tan rica...')
			watching = false
			distance.y = y_distance

#func _physics_process(delta):
#	passed_time += delta
#
#	if passed_time >= 1.0 / speed:
#		show()
#
#		passed_time = 0.0
#		done_steps += 1
#
#		if visibility_depth >= 0 and done_steps == visibility_depth:
#			EventsManager.emit_signal("possum_alerted")
#			# Aumentar la velocidad del enemigo como si etuviera afanado por
#			# llegar donde su posible presa
#			distance.y += 2
#
#		if done_steps <= show_steps:
#			play_show()
#		elif not smelling:
#			position += distance
#
#			if not leaving:
#				if done_steps <= walk_steps:
#					play_walk()
#				if done_steps >= collision_steps:
#					check_collision()
#			else:
#				var bodies = $Detector.get_overlapping_bodies()
#
#				for body in bodies:
#					if body.name == "Bounds":
#						leave_world()
#
#		print('Paso (%d)' % done_steps)


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


func leave_world() -> void:
	EventsManager.emit_signal("enemy_left")
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

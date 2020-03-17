extends 'res://src/Obstacles/SimpleObstacle.gd'
class_name Enemy
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
export(int) var visibility_frame: int = 0
export(bool) var hungry: bool = true
export(int) var smell_time: int = 0

const STATES = {
	APPEAR = 'Appear',			# Cuando aparece en la lejanía
	WALK = 'Walk',				# Cuando camina
	WATCH = 'Watch',			# Cuando se pilla a la Runcha
	SMELL = 'Smell',			# Cuando está olisqueando
	EAT = 'Eat',				# Cuando se come a la Runcha
	DISAPPEAR = 'Disappear'		# Cuando se va para el espacio exterior
}

onready var sprite: Sprite = $Sprite
onready var collision_shape: CollisionShape2D = $CollisionShape2D
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	$CollisionShape2D.disabled = true


func _on_world_moved() -> void:
	$StateMachine.state.world_tick()


func smell_SFX():
	EventsManager.emit_signal('play_requested', get_name(), 'Smell')


func _on_possum_done():
	set_z_index(4)

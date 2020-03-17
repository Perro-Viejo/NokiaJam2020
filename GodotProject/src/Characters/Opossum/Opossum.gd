extends 'res://src/Characters/Actor.gd'
class_name Opossum
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
const STATES = {
	RUNNING = 'Running',
	ALERT = 'Alert',
	PLAY_POSSUM = 'PlayPossum',
	CONTINUE = 'Continue'
}

var health

onready var _sprite: Sprite = $Sprite
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	# Conectar señales
	EventsManager.connect('possum_alerted', self, '_on_possum_alerted')
	EventsManager.connect('enemy_left', self, '_on_enemy_left')
	EventsManager.connect('world_tick', self, '_on_world_tick')
	
	# Establecer estado por defecto de algunas mierdas
	$Sprite/Alert.hide()


func _on_world_tick():
	$StateMachine.state.world_tick()


func play_animation(code, previous_state = ''):
	match code:
		STATES.RUNNING:
			# $Sprite/AnimationPlayer.play('Running', -1, 5)
			pass
		STATES.ALERT:
			$Sprite/AnimationPlayer.play('Alert')
		STATES.PLAY_POSSUM:
			$Sprite/AnimationPlayer.play('PlayPossum', -1, 2.0)
			EventsManager.emit_signal('play_requested' , get_name(), 'PlayPossum')
		STATES.CONTINUE:
			$Sprite/AnimationPlayer.play('PlayPossum', -1, -3.0, true)
			yield($Sprite/AnimationPlayer, 'animation_finished')
			EventsManager.emit_signal('play_requested' , get_name(), 'Wake')
			yield(get_tree().create_timer(0.2), 'timeout')
			EventsManager.emit_signal('possum_awake')
			$StateMachine.transition_to(STATES.RUNNING)


func _on_possum_alerted():
	$StateMachine.transition_to(STATES.ALERT)
	EventsManager.emit_signal('play_requested' , get_name(), 'Alert')

func _on_enemy_left():
	$StateMachine.transition_to(STATES.CONTINUE)


#--------Llamadas pal Audio Manager---------
func play_walk():
	EventsManager.emit_signal('play_requested' , get_name(), 'Walk')

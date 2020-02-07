extends "res://src/Obstacles/SimpleObstacle.gd"

var frames_cfg: Dictionary = {
	"show": {
		"frames": [0, 1],
		"steps_by_frame": [2, 2]
	},
	"walk": {
		"frames": [2, 3, 4, 5, 6],
		"steps_by_frame": [1, 1, 2, 2, 14]
	}
}
var current_frame: int = 0
var frame: int = 0
var step: int = 0


func _ready() -> void:
	$CollisionShape2D.disabled = true
	
	for _step in frames_cfg.show.steps_by_frame:
		show_steps += _step
	for _step in frames_cfg.walk.steps_by_frame:
		walk_steps += _step

func play_show():
	if frame >= frames_cfg.show.frames.size(): return
	
	$Sprite.set_frame(frames_cfg.show.frames[frame])
	# NOTA: Aquí se puede poner a sonar un SFX si se quiere
	
	step += 1
	if step > frames_cfg.show.steps_by_frame[frame]:
		frame += 1
		step = 0


func play_walk():
	if frame >= frames_cfg.walk.frames.size(): return
	
	$Sprite.set_frame(frames_cfg.walk.frames[frame])
	EventsManager.emit_signal("play_requested", get_name(), "Walk")
	
	step += 1
	if step > frames_cfg.walk.steps_by_frame[frame]:
		frame += 1
		step = 0


func play_smell():
	print('Cuántas veces')
	smelling = true
	$Detector/CollisionShape2D.disabled = true
	$Sprite/AnimationPlayer.play('Smell')
	EventsManager.emit_signal('enemy_approached', smell_time)

func smell_SFX():
	EventsManager.emit_signal("play_requested", get_name(), "Smell")


func _on_possum_done():
	smelling = false
	leaving = true
	set_z_index(4)
	distance.y *= 4
	$CollisionShape2D.disabled = true
	$Detector/CollisionShape2D.disabled = false
	$Sprite/AnimationPlayer.stop(true)
	$Sprite.set_frame(frames_cfg.walk.frames.back())

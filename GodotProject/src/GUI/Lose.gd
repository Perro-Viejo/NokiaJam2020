extends Panel
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var _first_anim: bool = true
var _listening: bool = false

onready var dflt_title: Dictionary = {
	pos_y = $Title.rect_position.y,
	color = $Title.self_modulate,
	rotation = $Title.rect_rotation
}
onready var dflt_subtitle_color: Vector2 = $Subtitle.self_modulate
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	$Title.rect_position.y -= 20
	$Title.self_modulate = Color(1, 1, 1, 0)
	$Title.rect_rotation = -15
	
	$Subtitle.self_modulate = Color(1, 1, 1, 0)
	
# warning-ignore:return_value_discarded
	$Tween.connect('tween_all_completed', self, '_on_tween_all_completed')


func _process(delta: float) -> void:
	if _listening and Input.get_action_strength('ui_accept'):
		EventsManager.emit_signal('level_restarted')


func _on_tween_all_completed() -> void:
	if _first_anim:
		_first_anim = false
		yield(get_tree().create_timer(0.3), 'timeout')
		animate_subtitle()
	else:
		_listening = true


func show() -> void:
	.show()
	animate_title()


func animate_title() -> void:
	# Mostrar la animación para el PERDISTES
	$Tween.interpolate_property(
		$Title,
		'self_modulate',
		$Title.self_modulate,
		dflt_title.color,
		0.4,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		$Title,
		'rect_position:y',
		$Title.rect_position.y,
		dflt_title.pos_y,
		0.2,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		$Title,
		'rect_rotation',
		$Title.rect_rotation,
		dflt_title.rotation,
		0.5,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	$Tween.start()


func animate_subtitle() -> void:
	$Tween.interpolate_property(
		$Subtitle,
		'self_modulate',
		$Subtitle.self_modulate,
		dflt_subtitle_color,
		0.3,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		$Title,
		'rect_position:y',
		$Title.rect_position.y,
		$Title.rect_position.y - 10,
		0.4,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	$Tween.start()

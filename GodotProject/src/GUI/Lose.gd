extends Panel
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
onready var dflt_title_pos_y: float = $Title.rect_position.y
onready var dflt_title_color: Vector2 = $Title.self_modulate
onready var dflt_subtitle_pos: Vector2 = $Subtitle.rect_position
onready var dflt_subtitle_color: Vector2 = $Subtitle.self_modulate
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	$Title.rect_position.y += 10
	$Title.self_modulate = Color(1, 1, 1, 0)
	
	$Subtitle.rect_position.y += 80
	$Subtitle.self_modulate = Color(1, 1, 1, 0)


func show():
	.show()
	$Tween.interpolate_property(
		$Title,
		'self_modulate',
		$Title.self_modulate,
		dflt_title_color,
		0.5,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		$Title,
		'rect_position:y',
		$Title.rect_position.y,
		dflt_title_pos_y,
		0.5,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	$Tween.start()

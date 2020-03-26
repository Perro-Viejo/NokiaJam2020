extends TextureRect
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
enum NUMBER_TO_PRESS_STATES {
	PRESSED_CORRECT,
	PRESSED_WRONG,
	SHOULD_PRESS,
	READY_TO_NEXT
}

var _number_to_press: String
var _current_state: int = NUMBER_TO_PRESS_STATES.READY_TO_NEXT;
var _minigame_done: bool = false

onready var control_node: Control = $"../.."
onready var right_pane_node: Panel = $".."
onready var gui_node: GUI = $"../../.." as GUI
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
# warning-ignore:return_value_discarded
	EventsManager.connect('possum_done', self, '_on_possum_done')


func _input(event: InputEvent):
	if (event is InputEventKey):
		var pressed_character = (event as InputEventKey).as_text()

		if _current_state == NUMBER_TO_PRESS_STATES.SHOULD_PRESS:
			if pressed_character == _number_to_press:
				_current_state = NUMBER_TO_PRESS_STATES.PRESSED_CORRECT
				control_node.get_node('InfoText').show_good_message()
				EventsManager.emit_signal('play_requested', 'UI', 'Pos_Fbk')
				for _particles in $Pos_Fbk.get_children():
					_particles.set_emitting(true)
			else:
				_current_state = NUMBER_TO_PRESS_STATES.PRESSED_WRONG
				lose_minigame()
				EventsManager.emit_signal('play_requested', 'UI', 'Neg_Fbk')


func _on_Timer_timeout():
	if _current_state == NUMBER_TO_PRESS_STATES.SHOULD_PRESS:
		lose_minigame()
	else:
		_current_state = NUMBER_TO_PRESS_STATES.READY_TO_NEXT
		$Tween.interpolate_property(
			self,
			'rect_position',
			right_pane_node.get_node('MiddlePosition').get_position(),
			right_pane_node.get_node('FinalPosition').get_position(),
			1,
			Tween.TRANS_LINEAR,
			Tween.EASE_OUT
		)
		$Tween.start()


func launch_number():
	if _minigame_done: return
	
	_current_state = NUMBER_TO_PRESS_STATES.READY_TO_NEXT
	_number_to_press = str(int(rand_range(0, 10)))
	
	$NumberToPress.set_text(_number_to_press)
	$Tween.interpolate_property(
		self,
		'rect_position',
		right_pane_node.get_node('InitialPosition').get_position(),
		right_pane_node.get_node('MiddlePosition').get_position(),
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	$Tween.start()


func start():
	_minigame_done = false

	launch_number()
	show()


func _on_Tween_tween_completed(object, key):
	var smell_bar: TextureProgress = gui_node._smell_bar
	
	if get_position() == right_pane_node.get_node('MiddlePosition').get_position():
		_current_state = NUMBER_TO_PRESS_STATES.SHOULD_PRESS
		$Timer.start()
	if get_position() == right_pane_node.get_node('FinalPosition').get_position():
		if !smell_bar.time_count_started:
			launch_number()
		elif smell_bar.time_count > 2:
			launch_number()


func lose_minigame() -> void:
	EventsManager.emit_signal('possum_discovered')


func _on_possum_done() -> void:
	_minigame_done = true

extends TextureRect

var number_to_press;

enum NUMBER_TO_PRESS_STATES {
	PRESSED_CORRECT,
	PRESSED_WRONG,
	SHOULD_PRESS,
	READY_TO_NEXT
}
var current_state = NUMBER_TO_PRESS_STATES.READY_TO_NEXT;

onready var control_node = get_parent().get_parent();
onready var right_pane_node = get_parent();
onready var smell_bar = control_node.get_node("LeftPanel/CenterContainer/SmellBar")


func _input(event: InputEvent):
	if (event is InputEventKey):
		var pressed_character = (event as InputEventKey).as_text()

		if current_state == NUMBER_TO_PRESS_STATES.SHOULD_PRESS:
			if pressed_character == number_to_press:
				current_state = NUMBER_TO_PRESS_STATES.PRESSED_CORRECT
				control_node.get_node("InfoText").show_good_message()
				EventsManager.emit_signal("play_requested", "UI", "Pos_Fbk")
			else:
				current_state = NUMBER_TO_PRESS_STATES.PRESSED_WRONG
				control_node.get_node("InfoText").show_bad_message()
				EventsManager.emit_signal("possum_discovered")
				EventsManager.emit_signal("play_requested", "UI", "Neg_Fbk")


func _on_Timer_timeout():
	if current_state == NUMBER_TO_PRESS_STATES.PRESSED_WRONG:
		EventsManager.emit_signal("possum_discovered")
	else:
		current_state = NUMBER_TO_PRESS_STATES.READY_TO_NEXT
		$Tween.interpolate_property(self, "rect_position", right_pane_node.get_node("MiddlePosition").get_position(), right_pane_node.get_node("FinalPosition").get_position(), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()


func launch_number():
	current_state = NUMBER_TO_PRESS_STATES.READY_TO_NEXT
	number_to_press = str(int(rand_range(0, 10)))
	$NumberToPress.set_text(number_to_press)
	$Tween.interpolate_property(self, "rect_position", right_pane_node.get_node("InitialPosition").get_position(), right_pane_node.get_node("MiddlePosition").get_position(), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()


func start():
	show()
	launch_number()


func _on_Tween_tween_completed(object, key):
	if get_position() == right_pane_node.get_node("MiddlePosition").get_position():
		current_state = NUMBER_TO_PRESS_STATES.SHOULD_PRESS
		$Timer.start()
	if get_position() == right_pane_node.get_node("FinalPosition").get_position():
		if !smell_bar.time_count_started:
			launch_number()
		elif smell_bar.time_count > 2:
			print("here2")
			launch_number()

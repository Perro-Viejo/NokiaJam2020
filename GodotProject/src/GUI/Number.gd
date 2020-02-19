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

func _ready():
	EventsManager.connect("possum_pretended", self, "_on_possum_alerted")	
	number_to_press = str(int(rand_range(0, 10)))
	$NumberToPress.set_text(number_to_press)
	set_position(right_pane_node.get_node("InitialPosition").get_position())
	set_visible(true)

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
		number_to_press = str(int(rand_range(0, 10)))
		$Tween.interpolate_property(self, "rect_position", right_pane_node.get_node("MiddlePosition").get_position(), right_pane_node.get_node("FinalPosition").get_position(), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
		
		$NumberToPress.set_text(number_to_press)

func _on_possum_alerted():
	set_visible(true)
	
	current_state = NUMBER_TO_PRESS_STATES.READY_TO_NEXT
	$Tween.interpolate_property(self, "rect_position", right_pane_node.get_node("InitialPosition").get_position(), right_pane_node.get_node("MiddlePosition").get_position(), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	
	$Timer.start()


func _on_Tween_tween_completed(object, key):
	if get_position() == right_pane_node.get_node("MiddlePosition").get_position():
		current_state = NUMBER_TO_PRESS_STATES.SHOULD_PRESS

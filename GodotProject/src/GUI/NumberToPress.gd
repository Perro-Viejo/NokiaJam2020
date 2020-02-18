extends Label

var number_to_press;
var number_pressed = false;
var should_press_number = false;
var is_good = false;

func _ready():
	EventsManager.connect("possum_pretended", self, "_on_possum_alerted")	
	number_to_press = str(int(rand_range(0, 10)))
	set_text(number_to_press)
	set_position($InitialPosition.get_global_position())
	set_visible(true)

func _input(event: InputEvent):
	
	if (event is InputEventKey):
		var pressed_character = (event as InputEventKey).as_text()

		if should_press_number:
			if pressed_character == number_to_press:
				is_good=true
				get_parent().get_node("InfoText").show_good_message()
				EventsManager.emit_signal("play_requested", "UI", "Pos_Fbk")
			else:
				is_good=false
				get_parent().get_node("InfoText").show_bad_message()
				EventsManager.emit_signal("possum_discovered")
				EventsManager.emit_signal("play_requested", "UI", "Neg_Fbk")
			should_press_number = false	
	
func _on_Timer_timeout():
	if not is_good:
		EventsManager.emit_signal("possum_discovered")
	else:
		should_press_number=true
		is_good=false
		number_to_press = str(int(rand_range(0, 10)))
		$Tween.interpolate_property(self, "position", $MiddlePosition.get_global_position(), $FinalPosition.get_global_position(), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
		
		set_text(number_to_press)

func _on_possum_alerted():
	set_visible(true)
	should_press_number = true
	$Tween.interpolate_property(self, "position", $InitialPosition.get_global_position(), $MiddlePosition.get_global_position(), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	
	$Timer.start()
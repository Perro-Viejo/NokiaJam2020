extends Label

var number_to_press;
var number_pressed = false;
var should_press_number = true;
var is_good = false;

func _ready():
	EventsManager.connect("possum_pretended", self, "_on_possum_alerted")	
	number_to_press = str(int(rand_range(0, 10)))
	set_text(number_to_press)
	set_visible(false)

func _input(event: InputEvent):
	
	if (event is InputEventKey):
		var character = (event as InputEventKey).as_text()

		if should_press_number and character.is_valid_integer():
			if character == number_to_press:
				is_good=true
				$InfoText.show_good_message()
				should_press_number=false
			else:
				is_good=false
				should_press_number=false
				$InfoText.show_bad_message()
				EventsManager.emit_signal("possum_discovered")
			
func _on_Timer_timeout():
	if not is_good:
		EventsManager.emit_signal("possum_discovered")
	else:
		should_press_number=true
		is_good=false
		number_to_press = str(int(rand_range(0, 10)))
		print("Oprima " + number_to_press + " malparido")
		
		set_text(number_to_press)

func _on_possum_alerted():
	set_visible(true)
	should_press_number = true
	$Timer.start()
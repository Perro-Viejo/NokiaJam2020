extends Label

const good_messages = ["Good", "OK!", "Yes", "100%", "+100"]
const bad_messages = ["Oops", "Bad", "No", "Sad", ":("]

var show_message = false;

func show_good_message():
	var message = int(rand_range(0, 5))
	show_message=true
	$Timer.start()
	$Timer.one_shot=true
	set_visible(true)
	set_text(good_messages[message])

func show_bad_message():
	var message = int(rand_range(0, 5))
	show_message=true
	$Timer.start()
	$Timer.one_shot=true
	set_visible(true)
	set_text(bad_messages[message])
	
func _on_Timer_timeout():
	set_visible(false)

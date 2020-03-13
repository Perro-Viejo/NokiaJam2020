extends Node2D

const buttons = [
	"PlayButtonLabel",
	"CreditsButtonLabel",
	"ExitButtonLabel"
];
var index = 0;
var selector;
var button;

func _ready():
	selector = load("res://src/TitleScreen/Selector.tscn").instance()
	add_child(load("res://src/Main/Managers/AudioManager.tscn").instance())
	set_selector_in_button()

func update_selector():
	set_selector_in_button()

func set_selector_in_button():
	button = get_node(buttons[index])
	var selector_intial_position = button.get_node("position")
	button.add_child(selector)
	selector.set_position(selector_intial_position.get_position())
		
func _input(event):
	if event is InputEventKey and event.pressed:
		button.remove_child(selector)
		
		if event.scancode == KEY_DOWN:
			EventsManager.emit_signal("play_requested" , "UI", "Cursor")
			index += 1
			if index >= buttons.size():
				index = buttons.size()-1
				
			
		if event.scancode == KEY_UP:
			EventsManager.emit_signal("play_requested" , "UI", "Cursor")
			index -= 1
			
			if index < 0:
				index = 0
		
		if event.scancode == KEY_ENTER:
			EventsManager.emit_signal("play_requested" , "UI", "Select")
			get_node(buttons[self.index]).excecute_command()
		
		update_selector()

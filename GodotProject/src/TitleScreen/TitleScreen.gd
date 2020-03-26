extends Node2D
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
const buttons = [
	'PlayButtonLabel',
	'CreditsButtonLabel',
	'ExitButtonLabel'
];

var index:int = 0;
var selector: Node;
var button: MainMenuButton;
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready():
	selector = load('res://src/TitleScreen/Selector.tscn').instance()
	add_child(load('res://src/Main/Managers/AudioManager.tscn').instance())
	set_selector_in_button()

func update_selector():
	set_selector_in_button()

func set_selector_in_button():
	button = get_node(buttons[index])
	var selector_intial_position = button.get_node('position')
	button.add_child(selector)
	selector.set_position(selector_intial_position.get_position())
		
func _input(event):
	if event is InputEventKey and event.pressed:
		button.remove_child(selector)
		
		var dir: int = 1
		
		match event.scancode:
			KEY_UP:
				dir = -1
				continue
			_:
				EventsManager.emit_signal('play_requested' , 'UI', 'Cursor')

		index = wrapi(index + dir, 0, buttons.size())

		if event.scancode == KEY_ENTER:
			EventsManager.emit_signal('play_requested' , 'UI', 'Select')
			get_node(buttons[index - 1]).excecute_command()
		
		update_selector()

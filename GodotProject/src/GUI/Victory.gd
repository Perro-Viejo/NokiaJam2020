extends Label
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var _listening: bool = false
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _process(delta: float) -> void:
	if _listening and Input.get_action_strength('ui_accept'):
		EventsManager.emit_signal('level_restarted')


func show() -> void:
	.show()

	EventsManager.emit_signal('play_requested', 'UI', 'Win')
	
	yield(get_tree().create_timer(1.3), "timeout")
	
	$Presionameste.show()
	EventsManager.emit_signal('play_requested', 'UI', 'Sub')

	yield(get_tree().create_timer(0.5), "timeout")
	
	EventsManager.emit_signal('play_requested', 'MX', 'Win')
	
	_listening = true

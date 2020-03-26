extends TextureProgress
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var time_count: int = 0
var time_count_started: bool = false

var _current_smell_time: int = 0
var _max_offset: int = 93
var _min_offset: int = 7
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	# Conectar señales
	$Timer.connect('timeout', self, '_on_timeout')

func start(smell_time: int) -> void:
	value = _max_offset
	time_count = smell_time
	_current_smell_time = smell_time
	time_count_started = true
	$Timer.start(1)
	show()

func _on_timeout():
	time_count -= 1
	value = time_count * _max_offset / _current_smell_time
	
	if value <= _min_offset:
		$Timer.stop()
		time_count_started = false
		EventsManager.emit_signal('possum_done')


func stop() -> void:
	$Timer.stop()

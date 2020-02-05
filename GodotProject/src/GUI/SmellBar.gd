extends TextureProgress

var time_count: int = 0
var current_smell_time: int = 0
var max_offset: int = 93
var min_offset: int = 7

func _ready() -> void:
	EventsManager.connect('enemy_approached', self, '_on_enemy_approached')
	$Timer.connect('timeout', self, '_on_timeout')

func _on_enemy_approached(smell_time) -> void:
	value = max_offset
	time_count = smell_time
	current_smell_time = smell_time
	
	$Timer.start(1)
	
func _on_timeout():
	time_count -= 1
	value = time_count * max_offset / current_smell_time
	
	if value <= min_offset:
		$Timer.stop()
		EventsManager.emit_signal('possum_done')

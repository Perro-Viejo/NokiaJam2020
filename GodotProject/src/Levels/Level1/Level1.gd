extends Node2D
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
export(int) var advance_tick = 2
export (int) var fruit_goal = 5
 
var current_frame: int = 0
var signal_sent: bool = false
var moving: bool = false
var tick_count: int = 0
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _ready() -> void:
	moving = true
	
	# Conectar señales
# warning-ignore:return_value_discarded
	$Timer.connect('timeout', self, '_animate_background')
# warning-ignore:return_value_discarded
	EventsManager.connect('possum_alerted', self, '_on_possum_alerted')
# warning-ignore:return_value_discarded
	EventsManager.connect('possum_awake', self, '_on_possum_awake')
# warning-ignore:return_value_discarded
	EventsManager.connect('enemy_left', self, '_on_object_left')
# warning-ignore:return_value_discarded
	EventsManager.connect('object_left', self, '_on_object_left')
# warning-ignore:return_value_discarded
	EventsManager.connect('item_picked', self, '_on_item_picked')
# warning-ignore:return_value_discarded
	EventsManager.connect('level_restarted', self, '_on_level_restarted')
	
	var _gui: GUI = load('res://src/GUI/GUI.tscn').instance()
	_gui.initialize(fruit_goal)
	
	add_child(_gui)
	add_child(load('res://src/Main/Managers/AudioManager.tscn').instance())
	
	# Iniciar la animación del fondo
	$Timer.start()


func _animate_background() -> void:
	if not signal_sent and current_frame == 0:
		signal_sent = true
		EventsManager.emit_signal('level_started')
	
	if moving:
		# Infinite loop between 0 and 9
		current_frame = wrapi(current_frame + 1, 0, $Background.hframes)
		$Background.set_frame(current_frame)
	
	tick_count += 1
	if tick_count == advance_tick:
		tick_count = 0
	
		# Emitir la señal que avisa que se 'movió' el fondo
		EventsManager.emit_signal('world_advanced')
	
	# Emitir la señal que avisa que se 'movió' el fondo
	EventsManager.emit_signal('world_tick')


func _on_possum_alerted() -> void:
	#$Timer.paused = true
	moving = false
	
	for spawner in $Spawners.get_children():
		var _spawner: Spawner = spawner as Spawner
		if _spawner:
			_spawner.spawning = false


func _on_object_left() -> void:
	for spawner in $Spawners.get_children():
		var _spawner: Spawner = spawner as Spawner
		if _spawner:
			_spawner.spawning = true


func _on_possum_awake() ->void:
	#$Timer.paused = false
	moving = true


func _on_item_picked(count) -> void:
	if count == fruit_goal:
		finish_level()
		print("Ganastes Gonorrea!")


func _on_level_restarted() -> void:
	get_tree().reload_current_scene()


func finish_level() -> void:
	for spawner in $Spawners.get_children():
		var _spawner: Spawner = spawner as Spawner
		if _spawner:
			_spawner.stop_spawner()
			yield(get_tree().create_timer(2), "timeout")
			_spawner.spawn_den()
	yield(get_tree().create_timer(4.7), "timeout")
	
	moving = false
	EventsManager.emit_signal("level_finished", 'Victory')

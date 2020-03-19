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
	$Timer.connect('timeout', self, '_animate_background')
	EventsManager.connect('possum_alerted', self, '_on_possum_alerted')
	EventsManager.connect('possum_awake', self, '_on_possum_awake')
	EventsManager.connect('enemy_left', self, '_on_object_left')
	EventsManager.connect('object_left', self, '_on_object_left')
	EventsManager.connect('item_picked', self, '_on_item_picked')
	
	
	add_child(load('res://src/GUI/GUI.tscn').instance())
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
		EventsManager.emit_signal("level_finished", 'Victory')
		print("Ganastes Gonorrea!")

func finish_level():
	moving = false
	for spawner in $Spawners.get_children():
		spawner.spawning = false 

extends "res://src/Main/StateMachine/State.gd"
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
var change_tick: int = 1
var tick: int = 0
# Guardar el tipo del owner para que sea más fácil acceder a propiedades y
# métodos de la clase.
onready var _owner: Enemy = owner as Enemy
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func enter(msg: Dictionary = {}) -> void:
	.enter(msg)
#	tick = 0
	_owner.animator.play("Eat")
	yield(_owner.animator, 'animation_finished')
	print('Me la comí y estuvo rico rico rcio')
#	EventsManager.emit_signal("level_finished", 'Defeat')


#func world_tick() -> void:
#	tick += 1
#
#	if tick >= change_tick:
#		tick = 0

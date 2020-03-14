extends Position2D
class_name Spawner
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
enum Side {LEFT = -2, MIDDLE = 0, RIGHT = 2}
enum Type {RND = -1, WOLF, CAT, PENGUIN}

export(Side) var side = Side.MIDDLE
export(Type) var dflt_type = Type.RND

var spawning: bool = true
var enemy_types: Array = [
	load('res://src/Characters/Enemies/Wolf/Wolf.tscn')
]
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _on_Timer_timeout():
	if not spawning: return
	
	var enemy = null
	if dflt_type == Type.RND:
		# Elegir un enemigo al azar y parirlo
		enemy_types.shuffle()
		enemy = enemy_types[0].instance() as SimpleObstacle
	else:
		# Crear el enemigo configurado por defecto (muy útil para hacer pruebas)
		enemy = enemy_types[dflt_type].instance() as SimpleObstacle

	enemy.position = position
	enemy.distance.x = side
	
	spawning = false
	get_parent().add_child(enemy)

extends Position2D
class_name Spawner
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Variables ▒▒▒▒
enum Side {LEFT = -2, MIDDLE = 0, RIGHT = 2}
enum Type {RND = -1, WOLF, FRUIT}

export(Side) var side = Side.MIDDLE
export(Type) var dflt_type = Type.RND

var spawning: bool = true
var object_types: Array = [
	load('res://src/Characters/Enemies/Wolf/Wolf.tscn'),
	load('res://src/Obstacles/Fruit/Fruit.tscn')
]
#▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Funciones ▒▒▒▒
func _on_Timer_timeout():
	if not spawning: return
	
	var object = null
	if dflt_type == Type.RND:
		# Elegir un objeto al azar y parirlo
		object_types.shuffle()
		object = object_types[0].instance() as SimpleObstacle
	else:
		# Crear el objeto configurado por defecto (muy útil para hacer pruebas)
		object = object_types[dflt_type].instance() as SimpleObstacle

	object.position = position
	object.distance.x = side
	
	spawning = false
	get_parent().add_child(object)

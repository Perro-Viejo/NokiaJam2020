extends GridContainer

const counter_scene = preload("res://src/GUI/FruitCounter.tscn")

var fruit_limit: int = 3
var counter

func _process(delta):
	if get_child_count() < fruit_limit:
		create_fruit()
		set_columns(fruit_limit)
		
func create_fruit():
	counter = counter_scene.instance()
	add_child(counter)

func count_fruit(count):
	if count <= get_child_count(): 
		get_child(count-1).pressed = true

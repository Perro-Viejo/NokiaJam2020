extends Timer

export (float, 0, 600) var min_time=5
export (float, 0, 600) var max_time=15


func _ready():
	init_rand()
	autostart = true
	connect('timeout', self, 'init_rand')
	
	
func init_rand():
	var wait_time = rand_range(min_time, max_time)
	set_wait_time(wait_time)

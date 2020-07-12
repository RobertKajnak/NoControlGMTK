extends Timer

var grace_cycles = 0
var current_cycle = 0
var acceleration_cycles = 4
var acceleration_value = 1
var acceleration_cap = 1

func _ready():
	pass


func _on_InsectTimer_timeout():
	current_cycle += 1
	if current_cycle>grace_cycles:
		$"/root/Global".add_insect()
		
	if current_cycle%acceleration_cycles==1 and wait_time-acceleration_value>=acceleration_cap:
		wait_time -= acceleration_value
	

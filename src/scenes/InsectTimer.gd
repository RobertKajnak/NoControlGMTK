extends Timer

var grace_cycles = 2
var current_cycle = 0
var acceleration_cycles = 6
var acceleration_value = 1
var acceleration_cap = 1

var buff_cylces = 10
var attack_buff = 1.2
var health_buff = 1.2

func _ready():
	pass


func _on_InsectTimer_timeout():
	current_cycle += 1
	if current_cycle>grace_cycles:
		$"/root/Global".add_insect(attack_buff, health_buff)
		if current_cycle % buff_cylces==1:
			health_buff += 0.2
			attack_buff += 0.2
		
		if current_cycle%acceleration_cycles==1 and wait_time-acceleration_value>=acceleration_cap:
			wait_time -= acceleration_value
		

	

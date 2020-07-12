extends Area2D

var possible_states = []
var growth_size = 0 # the stage of the plant
var reaching_distance = 10 # Used by bugs to see if they are touching the plant

func _ready():
	possible_states = [$Plant_1,$Plant_2,$Plant_3,$Plant_4,$Plant_5,$Plant_6]
	for sprite in possible_states:
		sprite.visible = false
	
	Global.plant_data.append(self)

func start_grow():
	growth_size = 1
	$Plant_1.visible = true
	$Timer.start()

func damage_by(damage):
	growth_size -= damage
	if growth_size<=0:
		$Timer.stop()
	update_size()
	return growth_size

func update_size():
	for i in range(len(possible_states)):
		if growth_size>=i and growth_size<i+1:
			possible_states[i].visible = true
		else:
			possible_states[i].visible = false
	
	
func _on_Timer_timeout():
	growth_size += 1
	update_size()
	

extends Area2D

var possible_states = []
var growth_size = 0

func _ready():
	# register position so robots and bugs know where plant positions are
	# also the 0 means that there is no plant there yet
	
	$Plant_1.visible = false
	$Plant_2.visible = false
	$Plant_3.visible = false
	$Plant_4.visible = false
	$Plant_5.visible = false
	$Plant_6.visible = false
	
	possible_states = [$Plant_1,$Plant_2,$Plant_3,$Plant_4,$Plant_5,$Plant_6]
	Global.plant_data.append(self)


func start_grow():
	growth_size = 1
	$Plant_1.visible = true
	$Timer.start()

func be_eaten(delta):
	growth_size -= delta
	if growth_size<=0:
		$Timer.stop()
	update_size()

func update_size():
	for i in range(len(possible_states)):
		if growth_size>=i and growth_size<i+1:
			possible_states[i].visible = true
		else:
			possible_states[i].visible = false
	
	
func _on_Timer_timeout():
	growth_size += 1
	update_size()
	

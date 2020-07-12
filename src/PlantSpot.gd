extends Area2D

var possible_states = []

func _ready():
	# register position so robots and bugs know where plant positions are
	# also the 0 means that there is no plant there yet
	Global.plant_data[global_position] = 0
	$"/root/Global".connect("plant_planted", self, "_on_Global_plant_planted")
	$"/root/Global".connect("plant_eaten", self, "on_Global_plant_eaten")
	$Plant_1.visible = false
	$Plant_2.visible = false
	$Plant_3.visible = false
	$Plant_4.visible = false
	$Plant_5.visible = false
	$Plant_6.visible = false
	
	possible_states = [$Plant_1,$Plant_2,$Plant_3,$Plant_4,$Plant_5,$Plant_6]

func _on_Global_plant_planted(location):
	if global_position == location:
		$Plant_1.visible = true
		$Timer.start()

func on_Global_plant_eaten(location, new_size):
	if global_position == location:
		update_size(new_size)
		if new_size<=0:
			$Timer.stop()

func update_size(new_size):
	for i in range(len(possible_states)):
		if new_size>=i and new_size<i+1:
			possible_states[i].visible = true
		else:
			possible_states[i].visible = false
	
	
func _on_Timer_timeout():
	var new_size = Global.plant_data[global_position] + 1
	Global.plant_data[global_position] = new_size
	update_size(new_size)
	

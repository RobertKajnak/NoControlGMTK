extends Area2D

func _ready():
	# register position so robots and bugs know where plant positions are
	# also the 0 means that there is no plant there yet
	Global.plant_data[global_position] = 0
	$"/root/Global".connect("plant_planted", self, "_on_Global_plant_planted")
	$Plant_1.visible = false
	$Plant_2.visible = false
	$Plant_3.visible = false
	$Plant_4.visible = false
	$Plant_5.visible = false
	$Plant_6.visible = false

func _on_Global_plant_planted(location):
	if global_position == location:
		$Plant_1.visible = true
		$Timer.start()


func _on_Timer_timeout():
	var new_size = Global.plant_data[global_position] + 1
	Global.plant_data[global_position] = new_size
	
	match new_size:
		2: 
			$Plant_1.visible = false
			$Plant_2.visible = true
		3: 
			$Plant_2.visible = false
			$Plant_3.visible = true
		4:
			$Plant_3.visible = false
			$Plant_4.visible = true
		5:
			$Plant_4.visible = false
			$Plant_5.visible = true
		6:
			$Plant_5.visible = false
			$Plant_6.visible = true
		_:
			pass
	
	

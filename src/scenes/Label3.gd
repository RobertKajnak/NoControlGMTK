extends Label

func _on_Timer_timeout():
	if Global.wait_time == 15:
		Global.wait_time = 0
	else:
		Global.wait_time = 	Global.wait_time + 1
		
	text = "Command Arrives in: " + str(Global.wait_time)

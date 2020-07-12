extends Button

var server_time = 0
var times = []

func _on_FightButton_button_down():
	times.append(server_time)
	
func _process(delta):
	print(server_time)
	server_time = server_time + delta
	for time in times:
		if server_time - time > 10:
			Global.action_state = "Fight"

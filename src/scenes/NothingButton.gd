extends Button

var server_time = 0
var times = []

func _on_NothingButton_button_down():
	times.append(server_time)
	
func _process(delta):
	server_time = server_time + delta
	for time in times:
		if server_time - time > 10:
			times.erase(time)
			Global.action_state = "Nothing"

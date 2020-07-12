extends Control

func _process(delta):
	$Current.text = "Current State: " + Global.action_state	

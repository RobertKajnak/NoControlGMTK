extends Area2D

signal show_action_menu

func _input_event(viewport, event, shape):
	if event is InputEventMouseButton and not event.is_pressed():
		emit_signal("show_action_menu")

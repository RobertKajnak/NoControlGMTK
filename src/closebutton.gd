extends Button

signal hide_action_menu

func _on_closebutton_button_down():
	emit_signal("hide_action_menu")

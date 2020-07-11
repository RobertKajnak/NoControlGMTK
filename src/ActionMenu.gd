extends Node2D

func _ready():
	visible = false

func _on_Antenna_show_action_menu():
	visible = true

func _on_closebutton_hide_action_menu():
	visible = false

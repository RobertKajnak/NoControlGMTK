extends Area2D

var max_health = 1000
var health = max_health
var reaching_distance = 70 # Minimum distance used by bugs to see if they are touching the base

func _ready():
	Global.base_position = position
	$HealthBar.max_value = max_health
	$HealthBar.value = health

func _on_PlantButton_button_down():
	pass # Replace with function body.

func damage_by(damage):
	health = health - damage * 10
	$HealthBar.value = health
	if health <= 0:
		get_node('/root/Node2D/LabelLose').visible = true
	return health

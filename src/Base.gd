extends Area2D

var max_health = 1000
var health = max_health
var reaching_distance = 70 # Minimum distance used by bugs to see if they are touching the base
var spikes = 0.5

func _ready():
	Global.base_position = position
	$HealthBar.max_value = max_health
	$HealthBar.value = health
	for robot in Global.robot_data:
		robot.global_position = global_position

func _on_PlantButton_button_down():
	pass # Replace with function body.

func damage_by(damage, damager):
	health = health - damage * 10
	$HealthBar.value = health
	if health <= 0:
		get_node('/root/Node2D/LabelLose').visible = true
	return health

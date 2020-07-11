extends KinematicBody2D

signal planted(position)

var has_plant = false
var speed = 100

func _ready():
	print(Global.base_position)

func _process(delta):
	match Global.action_state:
		"Nothing": pass
		"Plant":
			if not has_plant:
				position = position.move_toward(Global.base_position, delta * speed)
				has_plant = position.distance_to(Global.base_position) < 10
			else:
				var closest_plant_space = get_closest_unplanted(position, Global.get_plant_locations())
				position = position.move_toward(closest_plant_space, delta * speed)
				if position.distance_to(closest_plant_space) < 10:
					has_plant = false
					Global.perform_plant(closest_plant_space)
		var unrecognized:
			print("Unrecognized action state: " + str (unrecognized))

# TODO need to actually perform the check if it is planted or not
func get_closest_unplanted(robot_position, planting_positions):
	var best_position = robot_position
	var best_distance = 999999999
	for planting_position in planting_positions:
		var distance = robot_position.distance_to(planting_position)
		if distance < best_distance:
			best_distance = distance
			best_position = planting_position
	return best_position

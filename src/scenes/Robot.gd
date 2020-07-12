extends KinematicBody2D

signal planted(position)

var has_plant = false
var speed = 100 + rand_range(-50, 50)
var damage = 100

func _ready():
	Global.robot_data.append(self)

func _process(delta):
	$Confusion.visible = false
	match Global.action_state:
		"Nothing": pass
		"Plant":
			if not has_plant:
				position = position.move_toward(Global.base_position, delta * speed)
				has_plant = position.distance_to(Global.base_position) < 10
			else:
				var closest_plant_space = get_closest(Global.get_empty_plant_locations())
				if closest_plant_space != null:
					position = position.move_toward(closest_plant_space.global_position, delta * speed)
					if position.distance_to(closest_plant_space.global_position) < 10:
						has_plant = false
						closest_plant_space.start_grow()
		"Fight":
			if Global.insect_data.empty():
				$Confusion.visible = true
			else:
				var bogar = get_closest(Global.insect_data)
				position = position.move_toward(bogar.position, delta * speed)
				if position.distance_to(bogar.position) < 10:
					bogar.take_damage(delta * damage)
		var unrecognized:
			print("Unrecognized action state: " + str (unrecognized))
		
# TODO need to actually perform the check if it is planted or not
func get_closest(objects):
	var best_plant = null
	var best_distance = 999999999
	for unplanted in objects:
		var distance = position.distance_to(unplanted.global_position)
		if distance < best_distance:
			best_distance = distance
			best_plant = unplanted
	return best_plant

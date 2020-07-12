extends KinematicBody2D

signal planted(position)

var has_plant = false
var speed = 100 + rand_range(-50, 50)
var damage = 100

func _ready():
	Global.robot_data.append(self)

func _process(delta):
	$Confusion.visible = false
	var old_x = position.x
	var old_y = position.y
	
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
	
	var new_x = position.x
	var new_y = position.y
	
	$Robot_E.visible = false
	$Robot_N.visible = false
	$Robot_S.visible = false
	$Robot_SE.visible = false
	$Robot_NE.visible = false
	
	var biggest = max(abs(old_x - new_x), abs(old_y - new_y))
	var movement_vector = Vector2(old_x - new_x, old_y - new_y)
	
	var e = Vector2(biggest, 0)
	var se = Vector2(biggest, biggest)
	var s = Vector2(0, biggest)
	var sw = Vector2(-biggest, biggest)
	var w = Vector2(-biggest, 0)
	var nw = Vector2(-biggest, -biggest)
	var n = Vector2(0, -biggest)
	var ne = Vector2(biggest, -biggest)
	
	var closest = s
	var closest_dist = 100
	var list = [e, se, s, sw, w, nw, n, ne]
	for dir in list:
		if movement_vector.distance_to(dir) < closest_dist:
			closest_dist = movement_vector.distance_to(dir)
			closest = dir
	
	if closest == se:
		#print("True NW")
		$Robot_NE.flip_h = true
		$Robot_NE.visible = true	
	elif closest == ne:
		#print("NE")
		$Robot_SE.flip_h = true
		$Robot_SE.visible = true
	elif closest == e:
		#print("True E")
		$Robot_E.flip_h = true
		$Robot_E.visible = true
	elif closest == sw:
		#print("True NE")
		$Robot_NE.flip_h = false
		$Robot_NE.visible = true
	elif closest == nw:
		#print("True SE")
		$Robot_SE.flip_h = false
		$Robot_SE.visible = true
	elif closest == w:
		#print("True E")
		$Robot_E.flip_h = false
		$Robot_E.visible = true
	elif closest == s:
		#print("True N")
		$Robot_N.flip_h = false
		$Robot_N.visible = true
	else:
		#print("True S")
		$Robot_S.flip_h = true
		$Robot_S.visible = true
		
	
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

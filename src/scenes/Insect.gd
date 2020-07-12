extends KinematicBody2D

signal planted(position)

var eating_base = false
var speed = 100
var target = position
var offset_buzz = 0

func _ready():
	position = generate_starting_pos()
	target = position
	
func aquire_target():
	target = get_closest_planted( Global.get_plant_locations())
	if target == position:
		target = Global.base_position
	if position.distance_to(Global.base_position)<70:
		eating_base = true
		Global.add_base_eater()
	return target
	
func add_buzz_movement(delta):
	offset_buzz += delta*3.0 + (rand_range(-1,5) if not randi()%5 else 0)
	position += Vector2(sin(.20+offset_buzz),cos(.20+offset_buzz))*1.5
	
	
func _process(delta):
	if not eating_base:
		position = position.move_toward(target, delta * speed)
		
		if position.distance_to(target) < 10:
			Global.eat_plant(target, delta)
			if target != get_closest_planted( Global.get_plant_locations()):
				aquire_target()
	
	add_buzz_movement(delta)

func generate_starting_pos():
	var quadrant = randi()%3
	var x = 0
	var y =0
	if quadrant == 0:
		x = rand_range(800,2000)
		y = rand_range(-50,-20)
	elif quadrant == 1:
		x = rand_range(2000,2100)
		y = rand_range(-50,1000)
	else:
		x = rand_range(800,2000)
		y = rand_range(1000,1100)
	return Vector2(x,y)

func get_closest_planted(plant_poss):
	var best_position = position
	var best_distance = 999999999
	for plant_pos in plant_poss:
		var distance = position.distance_to(plant_pos)
		if distance < best_distance:
			best_distance = distance
			best_position = plant_pos
	return best_position

extends KinematicBody2D

signal planted(position)

var eating_base = false
var speed = 100
var max_health = 100
var health = max_health
var target = position
var offset_buzz = 0

func _ready():
	position = generate_starting_pos()
	target = aquire_target()
	$HealthBar.min_value = 0
	$HealthBar.max_value = max_health
	$HealthBar.value = health
	$HealthBar.visible = false
	
func aquire_target():
	target = get_closest_planted()
	if target == null:
		target = get_node('/root/Node2D/Base')
	if position.distance_to(Global.base_position)<70:
		eating_base = true
		Global.add_base_eater()
	return target
	
func add_buzz_movement(delta):
	offset_buzz += delta*3.0 + (rand_range(-1,5) if not randi()%5 else 0)
	position += Vector2(sin(.20+offset_buzz),cos(.20+offset_buzz))*1.5
	
func take_damage(damage):
	health = health - damage
	
	if health < 0:
		Global.kill_insect(self)
	
func _process(delta):
	$HealthBar.value = health
	$HealthBar.visible = health < max_health
	if not eating_base:
		position = position.move_toward(target.global_position, delta * speed)
		
		if position.distance_to(target.global_position) < 10:
			target.be_eaten(delta)
			if target.growth_size <= 0:
				aquire_target()
	
	add_buzz_movement(delta)

func generate_starting_pos():
	var quadrant = randi()%3
	var x = 0
	var y = 0
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

func get_closest_planted():
	var best_plant = null
	var best_distance = 999999999
	for unplanted in Global.get_plant_locations():
		var distance = position.distance_to(unplanted.global_position)
		if distance < best_distance:
			best_distance = distance
			best_plant = unplanted
	return best_plant


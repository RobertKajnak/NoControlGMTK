extends Node

signal plant_planted(location)
signal plant_eaten(location, size)

var calories = 0
var calorie_rate = 1

var base_position = "uninitialized"

#Number of bugs eating the stores inside the base
var eating_base = 0

# A Dictionary from position to plant data (a number)
var plant_data = {}
var insect_data = []

# Function called when a robot needs a list of empty plant locations
func get_empty_plant_locations():
	var result = []
	for loc in  plant_data.keys():
		if plant_data[loc] < 1:
			result = result + [loc]
	return result
	
	
# Procedure called when a robot puts a plant into the ground
func perform_plant(location):
	plant_data[location] = 1
	emit_signal("plant_planted", location)
	
# Called each second by the timer to update calorie count
func gather_calories():
	var total_plant_value = 0
	for val in Global.plant_data.values():
		total_plant_value = total_plant_value + val
	Global.calories = Global.calories + total_plant_value * calorie_rate
	

# Gets the already planted locaitons for the insects
func get_plant_locations():
	var result = []
	for loc in plant_data.keys():
		if plant_data[loc] > 0:
			result = result + [loc]
	return result
	

func add_insect():
	var insect:KinematicBody2D = load('res://src/scenes/Insect.tscn').instance()
	get_node('/root/Node2D').add_child_below_node(get_node('/root/Node2D/Antenna'),insect)
	print('Spawned bug at '+str(insect.position))
	insect_data.append(insect)
	
	
func eat_plant(location, delta):
	if location in plant_data:
		plant_data[location] -= delta/3.5
		emit_signal("plant_eaten", location, plant_data[location])
	
func add_base_eater():
	eating_base += 1
	if eating_base>10:
		get_node('/root/Node2D/LabelLose').visible = true
		
# Possible states: 
# 1 Nothing
# 2 Plant
# 3 Bot
# 4 Fight
var action_state = "Plant"

var wait_time = 0


#%% Input handling
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
			
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		pass        
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		# For android
		get_tree().quit()

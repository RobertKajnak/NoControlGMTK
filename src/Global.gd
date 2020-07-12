extends Node

var calories = 0
var calorie_rate = 1

var base_position = "uninitialized"

#Number of bugs eating the stores inside the base
var eating_base = 0

# A Dictionary from position to plant data (a number)
var plant_data = []
var insect_data = []

# Function called when a robot needs a list of empty plant locations
func get_empty_plant_locations():
	var result = []
	for plant in plant_data:
		if plant.growth_size <= 0:
			result.append(plant)
	return result
	
	
# Called each second by the timer to update calorie count
func gather_calories():
	var total_plant_value = 0
	for plant in plant_data:
		total_plant_value = total_plant_value + plant.growth_size
	Global.calories = Global.calories + total_plant_value * calorie_rate
	

# Gets the already planted locaitons for the insects
func get_plant_locations():
	var result = []
	for plant in plant_data:
		if plant.growth_size > 0:
			result.append(plant)
	return result
	

func add_insect():
	var insect:KinematicBody2D = load('res://src/scenes/Insect.tscn').instance()
	get_node('/root/Node2D').add_child_below_node(get_node('/root/Node2D/Antenna'),insect)
	#print('Spawned bug at '+str(insect.position))
	insect_data.append(insect)
	
func kill_insect(insect):
	insect_data.erase(insect)
	insect.queue_free()

		
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

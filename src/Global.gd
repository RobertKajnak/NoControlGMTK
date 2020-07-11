extends Node

signal plant_planted(location)

var calories = 0
var calorie_rate = 1

var base_position = "uninitialized"

# A Dictionary from position to plant data (a number)
var plant_data = {}

# Function called when a robot needs a list of empty plant locations
func get_plant_locations():
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
	
# Possible states: 
# 1 Nothing
# 2 Plant
# 3 Bot
# 4 Fight
var action_state = "Plant"

var wait_time = 0

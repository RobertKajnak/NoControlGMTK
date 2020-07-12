extends Area2D


# Called when the node enters the scene tree for the first time.
var button_names = {}
onready var butGerm = $"UpgradesContainer/Plant Upgrades/UpgradeContainer/ButtonGermination"
onready var butGrow =  $"UpgradesContainer/Plant Upgrades/UpgradeContainer/ButtonGrowthFactor"
onready var butRes = $"UpgradesContainer/Plant Upgrades/UpgradeContainer/ButtonResistance"
onready var butHealth = $"UpgradesContainer/Plant Upgrades/UpgradeContainer/ButtonHealth"
onready var butSpike = $"UpgradesContainer/Plant Upgrades/UpgradeContainer/ButtonSpikes"

onready var butSpeed = $"UpgradesContainer/Robot Upgrades/UpgradeContainer/ButtonSpeed"
onready var butDamage = $"UpgradesContainer/Robot Upgrades/UpgradeContainer/ButtonDamage"

var costs
var currentLevel

func _ready():
	$UpgradesContainer.visible = false
	
	button_names = {
		butGerm :'Germination: Level ',
		butGrow :'Gowth Speed: Level ',
		butRes :'Resistance: Level ',
		butHealth : 'Health: Level ',
		butSpike :'Spikiness: Level ',
		
		butSpeed : 'Speed: Level',
		butDamage : 'Damage: Level'
	}
	

	costs = {
		butGerm : 1000,
		butGrow : 100,
		butRes : 100,
		butHealth : 100,
		butSpike : 500,
		
		butSpeed : 300,
		butDamage : 200,
	}
	
	currentLevel = {
		butGerm : 0,
		butGrow : 0,
		butRes : 0,
		butHealth : 1,
		butSpike : 0,
		
		butSpeed : 1,
		butDamage : 1
	}
	
	update_display_name()
		
func update_display_name():
	for elem in button_names.keys():
		elem.text = button_names[elem] + str(currentLevel[elem])

func apply_effect(source):
	if Global.calories - costs[source] > 0:
		Global.calories -= costs[source]
		currentLevel[source] += 1
		update_display_name()
		return true
	return false
	
func _on_ButtonGrowthFactor_pressed():
	if apply_effect(butGrow):
		if Global.plant_speed <= 0.2:
			Global.plant_germination = 0.7
			currentLevel[butGerm] = 'Mutation 危険！'
		else:
			Global.plant_speed -= 0.05
			
func _on_ButtonResistance_pressed():
	if apply_effect(butRes):
		Global.plant_resistance *= 0.9


func _on_ButtonHealth_button_down():
	if apply_effect(butHealth):
		if Global.plant_health_bonus == 0:
			Global.plant_health_bonus += .1
		if Global.plant_health_bonus == 0.5:
			Global.plant_germination += 0.7
			currentLevel[butGerm] = 'Mutation 危険！'

func _on_ButtonSpikes_pressed():
	if apply_effect(butSpike):
		Global.plant_spikes += 2


func _on_ButtonGermination_pressed():
	if apply_effect(butGerm):
		Global.plant_germination += 0.05
	



func _on_Lab_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and not event.is_pressed():
		$"UpgradesContainer".visible = !$"UpgradesContainer".visible


func _on_ButtonSpeed_button_down():
	if apply_effect(butSpeed):
		for robot in Global.robot_data:
			robot.speed += 50
	

func _on_ButtonDamage_button_down():
	if apply_effect(butDamage):
		for robot in Global.robot_data:
			robot.damage += 20


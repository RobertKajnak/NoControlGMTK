extends Area2D

var possible_states = []
var growth_size = 0 # the stage of the plant
var reaching_distance = 10 # Used by bugs to see if they are touching the plant
var resistance = 1
var health_buff = 1
var spikes = 0

var not_plantable = false

func _ready():
	possible_states = [$Plant_1,$Plant_2,$Plant_3,$Plant_4,$Plant_5,$Plant_6]
	for sprite in possible_states:
		sprite.visible = false
	
	Global.plant_data.append(self)

func start_grow():
	growth_size = 1
	resistance = Global.plant_resistance
	health_buff = Global.plant_health_bonus
	spikes = Global.plant_spikes
	$Plant_1.visible = true
	$Timer.wait_time = Global.plant_speed
	$Timer.start()

func damage_by(damage, damager):
	growth_size -=  max(0, damage * resistance - health_buff)
	damager.take_damage(damage * spikes)
	if growth_size<=0:
		$Timer.stop()
	
	update_size()
	return growth_size

func update_size():
	for i in range(len(possible_states)):
		if growth_size>=i and growth_size<i+1:
			possible_states[i].visible = true
		else:
			possible_states[i].visible = false
	
func _on_Timer_timeout():
	growth_size = min(growth_size + 1,5.9)
	
	if rand_range(0,1) < Global.plant_germination:
		var offspring: Area2D = load('res://src/scenes/PlantSpot.tscn').instance()
		get_parent().add_child_below_node(get_parent().get_node('./Sprite'),offspring)
		
		var x_throw = rand_range(-110, 60)
		if x_throw<0:
			x_throw = min(x_throw,-25)
		else:
			x_throw = max(x_throw, 25)
			
		var y_throw = rand_range(55, 55)
		if y_throw<0:
			y_throw = min(y_throw,-25)
		else:
			y_throw = max(y_throw, 25)
			
		offspring.position = self.position + Vector2(x_throw,y_throw)
		offspring.not_plantable = true
		offspring.start_grow()
	
	update_size()
	

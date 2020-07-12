extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(5):
		for y in range(3):
			var plant:Area2D = load('res://src/scenes/PlantSpot.tscn').instance()
			
			get_node('.').add_child_below_node(get_node('./Sprite'),plant)
			plant.position = Vector2(90+x*130+randi()%55,65+75*y+randi()%35)
			
			plant.start_grow()
			


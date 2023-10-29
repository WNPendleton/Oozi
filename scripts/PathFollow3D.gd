extends PathFollow3D
@export var Path_Speed = 0.1
@export var init_counter = 0.2
@export var EncounterNode: Node3D

var path_end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if init_counter > 0:
		init_counter -= delta
	if init_counter <= 0:
		progress += delta * Path_Speed
		if progress_ratio == 1 && !path_end:
			print('Path Complete')
			EncounterNode.activate_encounter()
			path_end = true

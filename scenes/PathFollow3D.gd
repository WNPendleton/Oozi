extends PathFollow3D
@export var Path_Speed = 0.1
@export var New_Path: Path3D
@export var EncounterNode: Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	progress_ratio += delta * Path_Speed
	if progress_ratio == 1:
		print('Path Complete')
		EncounterNode.activate_encounter()
	pass

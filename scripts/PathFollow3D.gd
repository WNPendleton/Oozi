extends PathFollow3D
@export var Path_Speed = 0.1
@export var delay = 0.2
@export var initial_progress_ratio = 0.0
@export var EncounterNode: Node3D

var path_end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	progress_ratio = initial_progress_ratio

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if delay > 0:
		delay -= delta
	else:
		progress += delta * Path_Speed
		if progress_ratio == 1 && !path_end:
			if EncounterNode:
				EncounterNode.activate_encounter()
				path_end = true

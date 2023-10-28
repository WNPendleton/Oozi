extends Node3D
@export var PathFollow: PathFollow3D
@export var Next_Path: Path3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate_encounter():
	for _i in self.get_children():
		if _i.has_method("activate"):
			_i.activate()
		print(_i)
#	print('Running Encounter...')
#	await get_tree().create_timer(1).timeout
#	complete_encounter()
#	pass
	
func complete_encounter():
	print('Encounter Completed')
	PathFollow.get_parent().remove_child(PathFollow)
	Next_Path.add_child(PathFollow)
	PathFollow.progress_ratio = 0
	pass

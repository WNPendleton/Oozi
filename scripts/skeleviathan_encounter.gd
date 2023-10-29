extends Node3D

@export var PathFollow: PathFollow3D
@export var Next_Path: Path3D
@export var skeleviathan : Node3D

func activate_encounter():
	PathFollow.get_parent().remove_child(PathFollow)
	Next_Path.add_child(PathFollow)
	PathFollow.global_transform.origin = Next_Path.global_transform.origin + Vector3(0, 2, 0)
	PathFollow.progress_ratio = 0
	skeleviathan.start_encounter()

extends Node3D
@export var PathFollow: PathFollow3D
@export var Next_Path: Path3D
@onready var projectile_parent = get_tree().get_root().get_node_or_null(PlayerPathGetter.projectile_parent_path)

func activate_encounter():
	for _i in self.get_children():
		if _i.has_method("activate"):
			_i.activate()
	
func complete_encounter():
	if projectile_parent:
		for child in projectile_parent.get_children():
			child.queue_free()
	PathFollow.path_end = false
	PathFollow.get_parent().remove_child(PathFollow)
	Next_Path.add_child(PathFollow)
	PathFollow.global_position.y = 0
	PathFollow.progress_ratio = 0
	PathFollow.EncounterNode = Next_Path.path_end_encounter
	pass

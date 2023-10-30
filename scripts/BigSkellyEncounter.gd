extends Node3D
@export var PathFollow: PathFollow3D
@export var Next_Path: Path3D
@onready var player = get_tree().get_root().get_node(PlayerPathGetter.player_path)

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
	player.get_node("BossDeathSound").play()


extends Enemy

@onready var projectile_prefab = preload("res://prefabs/money_projectile.tscn")

func throw_money():
	var vector_offset = Vector3(-2, 2, 0)
	var bone_prefab = projectile_prefab.instantiate()
	get_parent().get_parent().add_child(bone_prefab)
	bone_prefab.projectile_speed = 3
	bone_prefab.global_transform.origin = global_transform.origin + -basis.z * 1 + vector_offset
	var direction = bone_prefab.global_transform.origin.direction_to(player.global_transform.origin)
	bone_prefab.direction = direction
	
func die():
	player.get_node("BossDeathSound").play()
	queue_free()

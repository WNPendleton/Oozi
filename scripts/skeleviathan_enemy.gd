extends Enemy

@onready var projectile_prefab = preload("res://prefabs/big_bone_projectile.tscn")

func throw_bone():
	var vector_offset = Vector3(2, 1.5, -2)
	var bone_prefab = projectile_prefab.instantiate()
	get_parent().get_parent().add_child(bone_prefab)
	var direction = (global_transform.origin + vector_offset).direction_to(player.global_transform.origin)
	bone_prefab.direction = direction
	bone_prefab.projectile_speed = 5.0
	bone_prefab.global_transform.origin = global_transform.origin + -basis.z * 1 + vector_offset

func die():
	player.get_node("BossDeathSound").play()
	queue_free()

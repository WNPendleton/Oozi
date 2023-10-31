extends Enemy

#@onready var anim = $Armature/AnimationPlayer
@onready var activate_delay_timer = $activate_delay_timer
@export var spawn_animation : String = "Spawn"
@export var attack_animation : String = "Throw"

@onready var projectile_prefab = preload("res://prefabs/big_bone_projectile.tscn")

func _ready():
	anim.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	activate_delay_timer.one_shot = true
	activate_delay_timer.connect("timeout", (Callable(self, "spawn")))
	#anim.play("Spawn")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Die":
		do_post_death()
	else: 
		anim.play(attack_animation)

func throw_bone():
	var vector_offset = Vector3(1, 5, 4)
	var bone_prefab = projectile_prefab.instantiate()
	get_parent().get_parent().add_child(bone_prefab)
	bone_prefab.projectile_speed = 3
	bone_prefab.global_transform.origin = global_transform.origin + -basis.z * 1 + vector_offset
	var direction = bone_prefab.global_transform.origin.direction_to(player.global_transform.origin)
	bone_prefab.direction = direction

func die():
	do_pre_death()

func do_pre_death():
	anim.play("Die")
	#Become encase in goo

func do_post_death():
	#Slowly Fade Away and then queue_free()
	var children_count = get_parent().get_child_count()
	if children_count - 1 <= 0:
		get_parent().complete_encounter()
	queue_free()
	pass
	
func activate():
	activate_delay_timer.start(activate_delay)
	
func spawn():
	print("spawning")
	show()
	anim.play(spawn_animation)

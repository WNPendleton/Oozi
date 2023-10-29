extends Enemy

#@onready var anim = $Armature/AnimationPlayer
@onready var activate_delay_timer = $activate_delay_timer
@export var spawn_animation : String

@onready var projectile_prefab = preload("res://prefabs/bone_remake.tscn")
@onready var player = get_tree().get_root().get_node(PlayerPathGetter.player_path)

func _ready():
	anim.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	activate_delay_timer.one_shot = true
	activate_delay_timer.connect("timeout", (Callable(self, "spawn")))
	#anim.play("Spawn")

func _on_animation_player_animation_finished(anim_name):
	
	if anim_name == "Throw":
		throw_bone()
		anim.play("Throw")
		return
	if anim_name == "Spawn":
		anim.play("Throw")
		return
	if anim_name == "Die":
		do_post_death()

func throw_bone():
	print("throwing bone")
	var bone_prefab = projectile_prefab.instantiate()
	bone_prefab.direction = global_transform.origin.direction_to(player.global_transform.origin)
	bone_prefab.projectile_speed = 1.0
	get_parent().get_parent().add_child(bone_prefab)

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
	anim.play(spawn_animation)

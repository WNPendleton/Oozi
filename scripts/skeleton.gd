extends Enemy

#@onready var anim = $Armature/AnimationPlayer
@onready var activate_delay_timer = $activate_delay_timer
@export var spawn_animation : String = "Spawn"
@export var attack_animation : String = "Throw"
@export var projectile_speed : float = 1.0

@onready var projectile_prefab = preload("res://prefabs/corrected_bone_projectile.tscn")

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
	var vector_offset = Vector3(0, 1.5, 0)
	var bone_prefab = projectile_prefab.instantiate()
	get_parent().get_parent().add_child(bone_prefab)	
	var direction = work_zone.global_transform.origin.direction_to(player.global_transform.origin)
	bone_prefab.direction = direction
	bone_prefab.projectile_speed = projectile_speed
	bone_prefab.global_transform.origin = work_zone.global_transform.origin

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
	show()
	if not anim.is_playing():
		anim.play(spawn_animation)

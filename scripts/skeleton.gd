extends Enemy

#@onready var anim = $Armature/AnimationPlayer
@onready var activate_delay_timer = $activate_delay_timer
@export var spawn_animation : String = "Spawn"
@export var attack_animation : String = "Throw"
@export var projectile_speed : float = 2.0
@export var face_player: bool = true

@onready var projectile_prefab = preload("res://prefabs/corrected_bone_projectile.tscn")

@onready var projectile_parent = get_tree().get_root().get_node_or_null(PlayerPathGetter.projectile_parent_path)

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
	var bone_prefab = projectile_prefab.instantiate()
	if projectile_parent:
		projectile_parent.add_child(bone_prefab)
	else:
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
	
func activate():
	activate_delay_timer.start(activate_delay)
	
func spawn():
	if face_player:
		look_at(player.global_transform.origin)
	if not anim.is_playing():
		anim.play(spawn_animation)
	show()

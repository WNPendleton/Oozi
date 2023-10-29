extends Enemy

#@onready var anim = $Armature/AnimationPlayer
@onready var activate_delay_timer = $activate_delay_timer
@export var spawn_animation : String
@export var attack_timer : int

@onready var projectile_prefab = preload("res://prefabs/bone_projectile.tscn")

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
	#Spawn a bone projectile
	pass

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

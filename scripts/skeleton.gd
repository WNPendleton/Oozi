extends CharacterBody3D

@onready var anim = $Armature/AnimationPlayer

func _ready():
	anim.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	anim.play("Spawn")

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

func do_pre_death():
	anim.play("Die")
	#Become encase in goo

func do_post_death():
	#Slowly Fade Away and then queue_free()
	pass

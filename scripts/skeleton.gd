extends CharacterBody3D

func _ready():
	$AnimationPlayer.play("Spawn")

func _on_animation_player_animation_finished(anim_name):
	
	if anim_name == "Throw":
		throw_bone()
		$AnimationPlayer.play("Throw")
		return
	if anim_name == "Spawn":
		$AnimationPlayer.play("Throw")
		return
	if anim_name == "Die":
		do_post_death()

func throw_bone():
	#Spawn a bone projectile
	pass

func do_pre_death():
	$AnimationPlayer.play("Die")
	#Become encase in goo

func do_post_death():
	#Slowly Fade Away and then queue_free()
	pass

extends Actor3D

@onready var anim = $Model/AnimationPlayer

func _process(delta):
	script_process(delta)

func do_attack():
	anim.play("Attack")

func do_spawn():
	anim.play("Spawn")

func do_despawn():
	anim.play_backwards("Spawn")

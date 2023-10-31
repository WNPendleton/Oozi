extends PathFollow3D

@export var path_speed = 1
@export var player_reference : Node3D
@export var attack_delay = 3.0

@onready var anim = $demonopoly/AnimationPlayer

var attack_timer = 0
var started = false

func _ready():
	anim.connect("animation_finished", Callable(self, "on_animation_finished"))
	start_encounter()

func _process(delta):
	if started:
		attack_timer += delta
		progress += path_speed * delta

func start_encounter():
	var timer : SceneTreeTimer = get_tree().create_timer(1)
	timer.connect("timeout", Callable(self, "play_transform"))

func play_transform():
	anim.play("Transform")

func on_animation_finished(anim_name):
	if anim_name == "Transform":
		started = true
		anim.play("Idle")
	elif attack_timer >= attack_delay:
		attack_timer = 0
		anim.play(["AttackLeft", "AttackRight"].pick_random())
		var bone_timer : SceneTreeTimer = get_tree().create_timer(1)
		bone_timer.connect("timeout", Callable($demonopoly, "throw_money"))
	else:
		anim.play("Idle")

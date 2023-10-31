extends CharacterBody3D
class_name Enemy

@export var max_health : int = 1
@export var activate_delay : float
@export var work_zone : Node3D

@onready var current_health = max_health
@onready var player = get_tree().get_root().get_node(PlayerPathGetter.player_path)
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var goo = preload("res://prefabs/goo_splash.tscn")

func get_hit(dmg = 1):
	if work_zone:
		work_zone.add_child(goo.instantiate())
	else:
		add_child(goo.instantiate())
	player.get_node("EnemyHitSound").play()
	current_health -= dmg
	if current_health <= 0:
		die()

func die():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	pass

extends CharacterBody3D
class_name Enemy

@export var max_health : int = 1
@export var activate_delay : float

var current_health = max_health

@onready var anim = $AnimationPlayer

func get_hit(dmg = 1, collider_name = ""):
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
	print("activating")

extends CharacterBody3D
class_name Enemy

@export var max_health : int = 1
@export var spawn_animation : String
@export var activate_delay : float

var current_health = max_health

@onready var anim = $Armature/AnimationPlayer
@onready var activate_delay_timer : Timer = $activate_delay_timer

func get_hit(dmg = 1):
	current_health -= dmg
	if current_health <= 0:
		die()

func die():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	activate_delay_timer.one_shot = true
	activate_delay_timer.connect("timeout", (Callable(self, "spawn"))) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	activate_delay_timer.start(activate_delay)
	
func spawn():
	anim.play(spawn_animation)

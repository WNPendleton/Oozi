extends RigidBody3D

@export var destructible : bool = true
@export var max_health : int = 1
@export var direction : Vector3 = Vector3(0, 0, 0)
@export var projectile_speed : float
@export var projectile_damage : int = 1

var current_health = max_health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate(direction * projectile_speed * delta)
	if !get_colliding_bodies().is_empty():
		for _i in get_colliding_bodies():
			if _i.has_method("player_get_hit"):
				_i.player_get_hit(projectile_damage)
		queue_free()

func get_hit(dmg):
	if destructible:
		current_health -= dmg
		if current_health <= 0:
			queue_free()

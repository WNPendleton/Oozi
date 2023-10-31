extends Node3D

@export var number_of_skeletons = 30
@export var rail_path : Path3D
@export var skelly_seed : int

@onready var skellycartleftprefab = preload("res://prefabs/skellycartleft.tscn")
@onready var skellycartrightprefab = preload("res://prefabs/skellycartright.tscn")

func _ready():
	seed(skelly_seed)
	update_skeletons()

func update_skeletons():
	print("Update skeletons")
	for i in range(number_of_skeletons):
		var ratio = (1.0 / number_of_skeletons) * i
		var type = [skellycartleftprefab, skellycartrightprefab].pick_random()
		var new_skellycart = type.instantiate()
		new_skellycart.Path_Speed = randf_range(-5, 8)
		new_skellycart.initial_progress_ratio = ratio
		var delay_time = 60.0 * ratio - 10
		new_skellycart.delay = delay_time
		rail_path.add_child(new_skellycart)
		new_skellycart.get_node("skeleton").activate_delay = delay_time
		new_skellycart.get_node("skeleton").projectile_speed = 2
		new_skellycart.get_node("skeleton").activate()

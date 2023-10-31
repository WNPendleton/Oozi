extends Control

var previous_mouse_mode
var bullet_texture = load("res://sprites/bullet.png")
var empty_bullet_texture = load("res://sprites/empty_bullet.png")
var heart_texture = load("res://sprites/life.png")
var empty_heart_texture = load("res://sprites/empty_life.png")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		var tree = get_tree()
		tree.paused = !tree.paused
		if tree.paused:
			previous_mouse_mode = Input.mouse_mode
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = previous_mouse_mode

func set_bullet_count(bullets):
	var list = $HUD/Ammo.get_children()
	for i in range(6):
		if bullets < i + 1:
			list[i].texture = empty_bullet_texture
		else:
			list[i].texture = bullet_texture

func set_current_health(health):
	var list = $HUD/Health.get_children()
	for i in range(5):
		if health < i + 1:
			list[i].texture = empty_heart_texture
		else:
			list[i].texture = heart_texture

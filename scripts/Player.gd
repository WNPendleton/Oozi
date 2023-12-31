extends CharacterBody3D

@export var next_level : String
@export var arm_range : Vector2
@export var arm_base : Vector2
@export var init_counter = 0.2
@export_category("Combat")
@export var max_ammo : int
@export var max_health : int = 5
@export var gun_damage : int = 1
@export var reload_timer : float = 2
@export var reload_text : Label
@export var UI : Control
@export_category("Path Following")
@export var chosen_path_follow : PathFollow3D
@export var path_follow_offset : Vector3
@export var follow_speed = 10
@export_category("Music")
@export var music : AudioStream

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var ray_length = 500.0
var reloading = false

@onready var current_health = max_health
@onready var current_ammo = max_ammo
@onready var current_reload_timer = $reload_timer
@onready var camera = get_viewport().get_camera_3d()

func _ready():
	$MusicPlayer.stream = music
	$MusicPlayer.play()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	current_reload_timer.connect("timeout", (Callable(self, "finish_reload")))
	current_reload_timer.one_shot = true
	UI.set_bullet_count(current_ammo)
	PlayerPathGetter.player_path = self.get_path()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().size
	# Sometimes the viewmodel will become misaligned based on initial mouse
	# position while loading scene. This 0.2 sec delay before tracking
	# the viewmodel to the mouse prevents this bug.
	if init_counter > 0:
		init_counter -= delta
		mouse_pos = Vector2(screen_size.x, 0)
	var mouse_offset = Vector2(float(mouse_pos.x)/screen_size.x-0.5, float(mouse_pos.y)/screen_size.y-0.5)
	$ArmAnchor.transform.basis = Basis()
	$ArmAnchor.rotate_object_local(Vector3(0,1,0), arm_base.x - (arm_range.x * mouse_offset.x))
	$ArmAnchor.rotate_object_local(Vector3(1,0,0), arm_base.y - (arm_range.y * mouse_offset.y))
	
	if init_counter <= 0:
		if chosen_path_follow != null:
			pass
			#global_transform.origin = global_transform.origin.lerp(chosen_path_follow.global_transform.origin + path_follow_offset, delta * follow_speed)
			#global_transform.origin = global_transform.origin.move_toward(chosen_path_follow.global_transform.origin, delta * follow_speed)
			#global_rotation = global_rotation.lerp(chosen_path_follow.global_rotation, delta * follow_speed)
			#global_rotation = global_rotation.move_toward(chosen_path_follow.global_rotation, delta * rotation_follow_speed)
	
	if Input.is_action_just_pressed("shoot"):
		if !reloading && current_ammo > 0:
			var hit = raycast_from_mouse(mouse_pos)
			if !hit.is_empty():
				var collider = hit.get("collider")
				if collider.has_method("get_hit"):
					collider.get_hit(gun_damage)
			current_ammo -= 1
			$ShootSound.play()
			UI.set_bullet_count(current_ammo)
		else :
			$ClickSound.play()
			
	if Input.is_action_just_pressed("reload"):
		if !reloading:
			current_reload_timer.start(reload_timer)
			reloading = true
			reload_text.show()
			$ReloadSound.play()
		
func raycast_from_mouse(mouse_pos):
	var ray_start = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_start + camera.project_ray_normal(mouse_pos) * ray_length
	var world3d : World3D = get_world_3d()
	var space_state = world3d.direct_space_state
	
	if space_state == null:
		return
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	query.collide_with_bodies = true
	query.collide_with_areas = false
	
	return space_state.intersect_ray(query)
	
func finish_reload():
	reloading = false
	reload_text.hide()
	current_ammo = max_ammo
	UI.set_bullet_count(current_ammo)
	
func player_get_hit(dmg):
	$HurtSound.play()
	current_health -= dmg
	UI.set_current_health(current_health)
	if current_health <= 0:
		game_over()
		
func game_over() :
	#Do the gameover thing here
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")


func _on_boss_death_sound_finished():
	get_tree().change_scene_to_file(next_level)

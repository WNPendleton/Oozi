class_name Actor3D extends Node3D

@export_category("Dialog")
@export var chat_box : TextureRect
@export var chat_text_box : Label
@export var chat_head_box : TextureRect
@export var chat_head_image : CompressedTexture2D

@export_category("Actions")
@export var eventList : Array[ScriptEvent]
@export var next_scene : PackedScene

@onready var smoke_puff_prefab = preload("res://prefabs/smoke_puff.tscn")

var elapsed_time = 0
var next_event

func _ready():
	ready_next_event()

func _process(delta):
	script_process(delta)

func script_process(delta):
	
	elapsed_time += delta
	
	if next_event and elapsed_time >= next_event.time:
		
		if has_method(next_event.start_action):
			call(next_event.start_action)
		elif next_event.start_action:
			printerr("Invalid start action given: ", next_event.start_action)
		
		if next_event.dialog_line:
			chat_text_box.text = next_event.dialog_line
			chat_head_box.texture = chat_head_image
			chat_box.show()
		
		var position_tween = get_tree().create_tween()
		position_tween.tween_property(self, "position", next_event.location, next_event.duration)
		
		var rotation_tween = get_tree().create_tween()
		var rotation_amt = Vector3(next_event.rotation.x, next_event.rotation.y, next_event.rotation.z)
		rotation_tween.tween_property(self, "rotation", rotation_amt, next_event.duration)
		
		var scale_tween = get_tree().create_tween()
		scale_tween.tween_property(self, "scale", next_event.size, next_event.duration)
		
		if has_method(next_event.end_action):
			scale_tween.tween_callback(Callable(self, next_event.end_action))
		elif next_event.end_action:
			printerr("Invalid end action given: ", next_event.end_action)
		
		scale_tween.tween_callback(Callable(self, "hide_chat_box"))
		
		ready_next_event()

func ready_next_event():
	next_event = eventList.pop_front()

func hide_chat_box():
	chat_box.hide()

func do_smoke_puff():
	var new_smoke_puff = smoke_puff_prefab.instantiate()
	new_smoke_puff.transform.origin = global_transform.origin + Vector3(0,1,0)
	get_tree().current_scene.add_child(new_smoke_puff)

func do_smoke_puff_and_hide():
	do_smoke_puff()
	hide()

func do_smoke_puff_and_show():
	do_smoke_puff()
	show()

func load_next_scene():
	get_tree().change_scene_to_packed(next_scene)

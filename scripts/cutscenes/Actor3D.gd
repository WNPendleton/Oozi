class_name Actor3D extends Node3D

@export var eventList : Array[ScriptEvent]

var elapsed_time = 0
var next_event

func _ready():
	ready_next_event()

func script_process(delta):
	
	elapsed_time += delta
	
	if next_event and elapsed_time >= next_event.time:
		
		if has_method(next_event.start_action):
			call(next_event.start_action)
		elif next_event.start_action:
			printerr("Invalid start action given: ", next_event.start_action)
			
		var position_tween = get_tree().create_tween()
		position_tween.tween_property(self, "position", next_event.location, next_event.duration)
		
		var rotation_tween = get_tree().create_tween()
		rotation_tween.tween_property(self, "rotation", next_event.rotation, next_event.duration)
		
		var scale_tween = get_tree().create_tween()
		scale_tween.tween_property(self, "scale", next_event.size, next_event.duration)
		
		if has_method(next_event.end_action):
			scale_tween.tween_callback(Callable(self, next_event.end_action))
		elif next_event.end_action:
			printerr("Invalid end action given: ", next_event.end_action)
		
		ready_next_event()

func ready_next_event():
	next_event = eventList.pop_front()

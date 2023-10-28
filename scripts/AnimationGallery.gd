extends Node3D

@export var animations : Array[String]

@onready var anim = $AnimationPlayer
@onready var animation_list = anim.get_animation_list()

var next_animation
var list_index = 0

func _ready():
	anim.connect("animation_finished", Callable(self, "play_next"))
	play_next(null)

func ready_next_animation():
	list_index += 1
	if list_index >= animations.size():
		list_index = 0

func play_next(thething):
	ready_next_animation()
	if animations.size() > list_index:
		anim.play(animations[list_index])

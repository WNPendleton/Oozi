extends CharacterBody3D

@export var right_glove_health : int = 15
@export var left_glove_health : int = 15
@export var right_hand_health : int = 10
@export var left_hand_health : int = 10
@export var monocle_health : int = 15
@export var right_eye_health : int = 10
@export var left_eye_health : int = 10
@export var moustache_health : int = 20
@export var right_horn_health : int = 10
@export var left_horn_health : int = 10
@export var brain_health : int = 5

@onready var right_glove = $Armature/Skeleton3D/Glove_R
@onready var left_glove = $Armature/Skeleton3D/Glove_L
@onready var right_hand = $Armature/Skeleton3D/Hand_R_2
@onready var left_hand = $Armature/Skeleton3D/Hand_L_2
@onready var monocle = $Armature/Skeleton3D/Monocle
@onready var right_eye = $Armature/Skeleton3D/Eye_R
@onready var left_eye = $Armature/Skeleton3D/Eye_L
@onready var moustache = $Armature/Skeleton3D/Moustache
@onready var right_horn = $Armature/Skeleton3D/Horn_R_2
@onready var left_horn = $Armature/Skeleton3D/Horn_L_2
@onready var brain = $Armature/Skeleton3D/Brain

@onready var right_glove_collider = $Glove_RCollider
@onready var left_glove_collider = $Glove_LCollider
@onready var right_hand_collider = $Hand_RCollider
@onready var left_hand_collider = $Hand_LCollider
@onready var monocle_collider = $MonocleCollider
@onready var right_eye_collider = $Eye_RCollider
@onready var left_eye_collider = $Eye_LCollider
@onready var moustache_collider = $MoustacheCollider
@onready var right_horn_collider = $Horn_RCollider
@onready var left_horn_collider = $Horn_LCollider
@onready var brain_collider = $BrainCollider

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_hit(dmg, collider_name):
	if collider_name == "Glove_RCollider":
		right_glove_health -= dmg
		if right_glove_health <= 0 :
			right_glove.queue_free()
			right_glove_collider.disabled = true
			if get_node_or_null("Armature/Skeleton3D/Glove_L") == null :
				right_hand_collider.disabled = false
				left_hand_collider.disabled = false
	if collider_name == "Glove_LCollider":
		left_glove_health -= dmg
		if left_glove_health <= 0 :
			left_glove.queue_free()
			left_glove_collider.disabled = true
			if get_node_or_null("Armature/Skeleton3D/Glove_R") == null :
				right_hand_collider.disabled = false
				left_hand_collider.disabled = false
	if collider_name == "Hand_RCollider":
		right_hand_health -= dmg
		if right_hand_health <= 0 :
			right_hand.queue_free()
			right_hand_collider.disabled = true
			if get_node_or_null("Armature/Skeleton3D/Hand_L_2") == null :
				monocle_collider.disabled = false
				right_eye_collider.disabled = false
	if collider_name == "Hand_LCollider":
		left_hand_health -= dmg
		if left_hand_health <= 0 :
			left_hand.queue_free()
			left_hand_collider.disabled = true
			if get_node_or_null("Armature/Skeleton3D/Hand_R_2") == null :
				monocle_collider.disabled = false
				right_eye_collider.disabled = false
	if collider_name == "MonocleCollider":
		monocle_health -= dmg
		if monocle_health <= 0 :
			monocle.queue_free()
			monocle_collider.disabled = true
			left_eye_collider.disabled = false
	if collider_name == "Eye_RCollider":
		right_eye_health -= dmg
		if right_eye_health <= 0 :
			right_eye.queue_free()
			right_eye_collider.disabled = true
			if get_node_or_null("Armature/Skeleton3D/Eye_L") == null :
				moustache_collider.disabled = false
	if collider_name == "Eye_LCollider":
		left_eye_health -= dmg
		if left_eye_health <= 0 :
			left_eye.queue_free()
			left_eye_collider.disabled = true
			if get_node_or_null("Armature/Skeleton3D/Eye_R") == null :
				moustache_collider.disabled = false
	if collider_name == "MoustacheCollider":
		moustache_health -= dmg
		if moustache_health <= 0 :
			moustache.queue_free()
			moustache_collider.disabled = true
			right_horn_collider.disabled = false
			left_horn_collider.disabled = false
	if collider_name == "Horn_RCollider":
		right_horn_health -= dmg
		if right_horn_health <= 0 :
			right_horn.queue_free()
			right_horn_collider.disabled = true
			if get_node_or_null("Armature/Skeleton3D/Horn_L_2") == null :
				brain_collider.disabled = false
	if collider_name == "Horn_LCollider":
		left_horn_health -= dmg
		if left_horn_health <= 0 :
			left_horn.queue_free()
			left_horn_collider.disabled = true
			if get_node_or_null("Armature/Skeleton3D/Horn_R_2") == null :
				brain_collider.disabled = false
	if collider_name == "BrainCollider":
		brain_health -= dmg
		if brain_health <= 0 :
			brain.queue_free()
			win_game()
			
func win_game():
	#do whatever to trigger the end game cutscene
	pass

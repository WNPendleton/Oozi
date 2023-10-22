class_name ScriptEvent extends Resource

## What time should this action start
@export var time = 0.0
## How long should this action last
@export var duration = 0.0
## Where should the actor be when the action is complete
@export var location = Vector3(0,0,0)
## What should the actor's rotation be when the action is complete
@export var rotation = Vector3(0,0,0)
## What should the actor's size be when the action is complete
@export var size = Vector3(1,1,1)
## Name of function the actor should call as it starts its action (Useful for triggering animations and effects)
@export var start_action : String
## Name of function the actor should call when it finishes its action (Useful for triggering animations and effects)
@export var end_action : String

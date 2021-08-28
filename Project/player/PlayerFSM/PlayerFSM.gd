extends "res://StateMachine/FSM.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	initialize()

func _input(event):
	currentState.handle_input(event)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

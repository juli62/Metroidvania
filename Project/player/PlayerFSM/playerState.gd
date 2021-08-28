extends "res://StateMachine/State.gd"

var animation : AnimatedSprite
var player : KinematicBody2D
func _ready():
	player = owner
	animation = player.get_node("AnimatedSprite")

func handle_input(event):
	pass
	
func animation_finished():
	pass		

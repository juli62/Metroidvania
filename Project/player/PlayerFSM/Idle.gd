extends "res://player/PlayerFSM/playerState.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	if  owner.velocity.y == 0:
		animation.play("Idle")
	
func handle_input(event):
	if(event.is_action_pressed("ui_left")):
		emit_signal("finished", "Run")
	elif(event.is_action_pressed("ui_right")):
		emit_signal("finished", "Run")
	elif(event.is_action_pressed("ui_up")):
		emit_signal("finished", "Jump")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

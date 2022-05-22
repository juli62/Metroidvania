extends "res://player/PlayerFSM/playerState.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func enter():
	animation.play("Crouch")
	#print("brinBAsio")	
	owner.crouch = true
func _process(delta):
	
	if player.velocity.x != 0 && owner.is_on_floor():
		emit_signal("finished", "Run")
	elif Input.is_action_just_pressed("jump") && owner.is_on_floor(): 
		emit_signal("finished", "Jump")
	if Input.is_action_just_released("ui_down") && player.velocity.x == 0 && player.aim_up == false:
		emit_signal("finished", "Idle")	
func exit():
	pass
	#print("bobosio")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

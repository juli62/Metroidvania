extends "res://player/PlayerFSM/playerState.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func enter():
	if $"../..".dead == false:
		owner.shooting = true
		owner.aim_up = true
	
func _process(delta):
	#air gun stuff
	if player.velocity.y > 0 && player.aim_up == true:
		animation.play("Fall_GU")
	elif player.velocity.y < 0 && player.aim_up == true:
		animation.play("Jump_GU")		
	
	
	#exits
	if player.velocity.x != 0 && owner.is_on_floor():
		emit_signal("finished", "Run")
	elif Input.is_action_just_pressed("jump") && owner.is_on_floor(): 
		emit_signal("finished", "Jump")
	if Input.is_action_just_released("ui_up") && player.velocity.x == 0:
		emit_signal("finished", "Idle")	
func exit():
	owner.aim_up = false
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

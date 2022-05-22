extends "res://player/PlayerFSM/playerState.gd"

var down = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func enter():
	pass
func _process(delta):
	
	player.aim=1
	
	if Input.is_action_just_pressed("Shoot"):	
		owner.shooting = true
		player.shoot()
	if owner.shooting == true && owner.velocity.x != 0 && owner.is_on_floor() && player.crouch == false:
		animation.play("Run_G")	
		player.aim = 1
	elif owner.shooting == true && owner.velocity.x == 0 && player.crouch == false && player.is_on_floor():
		animation.play("Gun")
		player.aim = 1
	#aim up
	if Input.is_action_pressed("ui_up"):
		player.aim_up = true
	if player.aim_up == true && player.velocity.x == 0:
		animation.play("Aim_UP")
		player.aim = 2
		#print(player.aim_up)
	elif player.velocity.x != 0:
		player.aim_up = false
		#print(player.aim_up)
	# air gun stuff
	if player.velocity.y > 0 && player.shooting == true && player.aim_up == false:
		animation.play("Fall_G")
		player.aim = 1
	elif player.velocity.y < 0 && player.shooting == true && player.aim_up == false:
		animation.play("Jump_G")	
		player.aim = 1
	#air gun down stuff Boi
	
	down = true if Input.is_action_pressed("ui_down")  else false
	
	if player.velocity.y > 0  && player.aim_up == false && down == true:
		animation.play("Fall_GD")
		player.aim = 3
	elif player.velocity.y < 0  && player.aim_up == false && down == true:
		animation.play("Jump_GD")	
		player.aim = 3
	
	
	
	#crouch shooty
	if player.crouch == true && player.velocity.x == 0 && player.is_on_floor() && player.shooting == true:
		animation.play("Crouch_G")
		player.aim = 4
	if player.crouch == true && player.velocity.x !=0:
		player.crouch = false
	#exits
	if Input.is_action_pressed("ui_up") && player.velocity.x == 0:
		emit_signal("finished", "aim_up")	
	if Input.is_action_just_released("ui_up") && player.velocity.x == 0:
		player.shooting = false
		emit_signal("finished", "Idle")	
	if Input.is_action_pressed("jump") && player.is_on_floor():
		emit_signal("finished", "Jump")


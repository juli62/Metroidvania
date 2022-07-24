extends "res://player/PlayerFSM/playerState.gd"



export var run_Speed = 300


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	owner.velocity.x = 0
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	if Input.is_action_pressed("jump") && player.is_on_floor():
			emit_signal("finished", "Jump")	

#old jump handler, don't know why i wrote it like this, might come up later??	
#	if left && Input.is_action_pressed("jump") && player.is_on_floor():
#		emit_signal("finished", "Jump")	
#	elif right && Input.is_action_pressed("jump") && player.is_on_floor():
#		emit_signal("finished", "Jump")		
	
	
#Movement	
	if $"../..".dead == false:
		if left:
			owner.velocity.x = -run_Speed
			animation.flip_h = true
		elif right:
			owner.velocity.x = run_Speed
			animation.flip_h = false
		
		#Friction, breaks animations. Will figure out later
		#else:
		#	owner.velocity.x = lerp(owner.velocity.x, 0 , 0.3)
		player.move_and_slide(owner.velocity)
		
	#print(owner.velocity.x)	
#Exits	
	if owner.velocity.x == 0 && owner.crouch == false && owner.aim_up == false:
			emit_signal("finished", "Idle")
	if left && owner.is_on_floor() && owner.shooting == false:
		animation.play("Run")
	elif right && owner.is_on_floor() && owner.shooting == false:
		animation.play("Run")		
		
	if Input.is_action_pressed("Shoot"):
		emit_signal("finished", "Shooting")	
func _ready():
	pass
func update(delta):
	pass
		
	
func enter():
	if owner.shooting == false:		
		animation.play("Run")	
		#print("blanbi")
		
func handle_input(event):
	if (event.is_action_pressed("ui_up")):
		emit_signal("finished", "aim_up")	

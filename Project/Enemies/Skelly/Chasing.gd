extends "res://StateMachine/State.gd"

var goin = false
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func enter():
	owner.chasing = true
	owner.spot()
	print("Dandil")
	owner.motion.x = 0
	$"../../Timer".start()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = (owner.position - owner.target.position).normalized()
	if owner.chasing == true && goin == true:
		owner.motion.x = owner.target.position.x
		if owner.target.position.x > owner.position.x:
			$"../../AnimatedSprite".flip_h = false
			owner.motion.x = -dir.x * 130
		if owner.target.position.x < owner.position.x:
			$"../../AnimatedSprite".flip_h = true
			owner.motion.x = dir.x * -130
	if owner.Dead == true:
		owner.chasing = false		
	if $"../../Left".is_colliding() == false || $"../../Right".is_colliding() == false:
		if owner.chasing == true && owner.jump == false:
				owner.jump()
				owner.jump = true
				
	elif  $"../../Left".is_colliding() == true|| $"../../Right".is_colliding() ==true:
		owner.jump = false		



func _on_Timer_timeout():
	goin = true

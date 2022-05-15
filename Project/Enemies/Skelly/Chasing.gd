extends "res://StateMachine/State.gd"
var spotted = false
var goin = false
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func enter():
	owner.chasing = true
	if spotted == false:
		owner.spot()
		spotted = true
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
			owner.motion.x = -dir.x * 16
		if owner.target.position.x < owner.position.x:
			$"../../AnimatedSprite".flip_h = true
			owner.motion.x = dir.x * -16
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


func _on_Range_body_entered(body):
	if body.name == "Player" && owner.Dead == false && owner.chasing == true:
		emit_signal("finished", "Attack")

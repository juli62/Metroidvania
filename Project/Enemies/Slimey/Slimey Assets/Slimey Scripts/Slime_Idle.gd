extends "res://StateMachine/State.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	owner.motion.x = speed


func enter():
	owner.chasing = false
	print("slimey ugh so good")
	$"../../AnimatedSprite".play("Idle")
	owner.motion.x = speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	owner.move_and_slide(owner.motion)
	
	if owner.chasing == false:
		if $"../../Right_bump".is_colliding():
			owner.motion.x = -speed
		elif $"../../Left_bump".is_colliding():
			owner.motion.x = speed
		if $"../../DL_bump".is_colliding() == false:
			owner.motion.x = speed
		elif $"../../DR_bump".is_colliding() == false:
			owner.motion.x = -speed
		if $"../../LOS".is_colliding() && $"../../LOS".get_collider().is_in_group("player") && owner.spotted == false:	
			if owner.spotted == false:
				owner.spot()
			emit_signal("finished", "Slime_Attack")

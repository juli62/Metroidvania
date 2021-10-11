extends "res://StateMachine/State.gd"

var idle = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func enter():
	idle = true
# Called when the node enters the scene tree for the first time.
func _ready():
	print("DANKINKIN")
	
	owner.motion.x = -50
	owner.move_and_collide(owner.motion)

func _physics_process(delta):
	if idle == true:	
		owner.move_and_slide(owner.motion)
		#animation flip, yes TOO MANY LINES. leave me alone :(
		if owner.motion.x > 0:
			$"../../AnimatedSprite".flip_h = false
		else:
			$"../../AnimatedSprite".flip_h = true
		if owner.motion.x != 0:
			$"../../AnimatedSprite".play("Walk")	
		if $"../../Right".is_colliding() == false:
			owner.motion.x = -50
		elif $	"../../Left".is_colliding() == false:
			owner.motion.x = 50
	if owner.Dead == true:
		idle = false	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D2_body_entered(body):
	if body.name == "Player" && owner.Dead == false && owner.chasing == false:
		emit_signal("finished", "Chasing")
		

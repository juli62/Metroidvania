extends "res://StateMachine/State.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var attacking = false
var timer = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	owner.motion.x = 0
	owner.chasing = true
	$"../../AnimatedSprite".play("Attack")
	print("kaka")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	pass

func _on_AnimatedSprite_animation_finished():
	if owner.chasing == true:
		var dir = (owner.position - owner.target.position).normalized()
		owner.motion.x = owner.target.position.x
		if owner.target.position.x > owner.position.x:
			$"../../AnimatedSprite".flip_h = false
			owner.motion.x = -dir.x * 90
		if owner.target.position.x < owner.position.x:
			$"../../AnimatedSprite".flip_h = true
			owner.motion.x = dir.x * -90	
	$"../../Timer".start()

func _on_Timer_timeout():
	owner.motion.x = 0
	owner.chasing = true
	$"../../AnimatedSprite".frame = 0
	
func exit():
	owner.chasing = false	

extends "res://StateMachine/State.gd"
var attack = false
var idle = false
onready var player = get_node("Player")
var spotted = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func enter():
	idle = true
# Called when the node enters the scene tree for the first time.
func _ready():
	print("DANKINKIN")
	
	owner.motion.x = -10
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
			owner.motion.x = -10
		elif $	"../../Left".is_colliding() == false:
			owner.motion.x = 10
		if $"../../WR".is_colliding() == true:
			owner.motion.x = -10
		elif $	"../../WL".is_colliding() == true:
			owner.motion.x = 10	
	if owner.Dead == true:
		idle = false	
	if $"../../Eyesight".is_colliding() && $"../../Eyesight".get_collider().is_in_group("player") && spotted == false:
		emit_signal("finished", "Chasing")
		spotted = true
# Called every frame. 'delta' is the elapsed time since the previous frame.

#Newer player detection, will move to physics_process  
#func _process(delta):
#	if $"../../Eyesight".is_colliding() && $"../../Eyesight".get_collider().owner is Player:
#		emit_signal("finished", "Chasing")
	
# Old player detection, will change from an Area2D to a Raycast to make it impossible to "see" through walls for the Enemies
#func _on_Area2D2_body_entered(body):
#	if body.name == "Player" && owner.Dead == false && owner.chasing == false:
#		emit_signal("finished", "Chasing")
#

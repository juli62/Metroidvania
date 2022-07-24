extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inside = false
var motion = Vector2()
var spotted = false
export (PackedScene) var Spotted
onready var target = get_parent().get_node("Player")
var chasing = false
signal strike
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	if motion.x > 0:
		$"AnimatedSprite".flip_h = true
		$"LOS".rotation_degrees = -90
	elif motion.x < 0:	
		$"AnimatedSprite".flip_h = false
		$"LOS".rotation_degrees = 90

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y = 91
	move_and_slide(motion)
func spot():
	var s = Spotted.instance()
	owner.add_child(s)
	s.transform = $"Spotted".global_transform		
	spotted = true


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		inside = true
		$"hit_time".start()
		emit_signal("strike")
		


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		inside = false


func _on_hit_time_timeout():
	if inside == true:
		emit_signal("strike")
		$"hit_time".start()

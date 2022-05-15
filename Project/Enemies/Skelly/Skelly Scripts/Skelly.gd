extends KinematicBody2D
export (PackedScene) var SkellyH
export (PackedScene) var Spotted
var motion = Vector2()
var Dead = false
var chasing = false
var jump = false
signal strike
#Jump calculations { 

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

# } Jump Calculations 

onready var target = get_parent().get_node("Player")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _physics_process(delta):
	if Dead == false:
		motion.y += get_gravity() * delta
	motion = move_and_slide(motion, Vector2.UP)

	move_and_slide(motion)
	 
# Called when the node enters the scene tree for the first time.

	
func death():
	motion.x = 0 
	$"AnimatedSprite".play("Dead")	
	$"CollisionShape2D".free()
	$"SkellyFSM/Attack/Range".free()
	Dead = true
	head()
func head():
	var h = SkellyH.instance()
	owner.add_child(h)
	h.transform = $"Head".global_transform		
func spot():
	var s = Spotted.instance()
	owner.add_child(s)
	s.transform = $"Spotted".global_transform		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_gravity() -> float:
	return jump_gravity if motion.y < 0.0 else fall_gravity

func jump():
	motion.y = jump_velocity

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dead":
		queue_free()
	




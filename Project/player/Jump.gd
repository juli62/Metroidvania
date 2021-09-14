extends "res://player/PlayerFSM/playerState.gd"

export var move_speed = 200.0



export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta):

	owner.velocity.y += get_gravity() * delta
	
	if Input.is_action_just_released("jump") && owner.velocity.y < 0:
		owner.velocity.y = 0
	
	
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)

func get_gravity() -> float:
	return jump_gravity if owner.velocity.y < 0.0 else fall_gravity

func jump():
	owner.velocity.y = jump_velocity

func enter():
	jump()
		

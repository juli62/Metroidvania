extends KinematicBody2D

var velocity = Vector2()
var run_Speed = 300
var UP = Vector2(0, -1)
# Called when the node enters the scene tree for the first time.
onready var sprite = $AnimatedSprite
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = 0
	get_input()
	velocity = move_and_slide(velocity, UP)


func get_input():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	
	if left:
		velocity.x -= run_Speed
		sprite.flip_h = true
		sprite.play("Run")
	elif right:
		velocity.x += run_Speed
		sprite.flip_h = false
		sprite.play("Run")
	else:
		sprite.play("Idle")	

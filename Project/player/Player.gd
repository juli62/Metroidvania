extends KinematicBody2D
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
onready var sprite = $AnimatedSprite
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	
	if velocity.y > 0:
		print(velocity.y)
		sprite.play("Fall")
	elif velocity.y < 0:
		sprite.play("Jump")	
	elif is_on_floor():
		velocity.y = 0
		

#	gravity.y = 918
#	gravity = move_and_slide(gravity)
##	
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	velocity.x = 0
#	get_input()
#	velocity = move_and_slide(velocity, UP)
#
#
#func get_input():
#	var left = Input.is_action_pressed("ui_left")
#	var right = Input.is_action_pressed("ui_right")
#
#	if left:
#		velocity.x -= run_Speed
#		sprite.flip_h = true
#		sprite.play("Run")
#	elif right:
#		velocity.x += run_Speed
#		sprite.flip_h = false
#		sprite.play("Run")
#	else:
#		sprite.play("Idle")	
#

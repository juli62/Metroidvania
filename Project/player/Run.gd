extends "res://player/PlayerFSM/playerState.gd"


export var run_Speed = 300


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	owner.velocity.x = 0
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	
	if left:
		owner.velocity.x -= run_Speed
		animation.flip_h = true
	elif right:
		owner.velocity.x += run_Speed
		animation.flip_h = false
	player.move_and_slide(owner.velocity)
	if owner.velocity.x == 0:
			emit_signal("finished", "Idle")
	if Input.is_action_just_pressed("ui_up"):
		emit_signal("finished", "Jump")	
	if left && owner.velocity.y == 0:
		animation.play("Run")
	elif right && owner.velocity.y == 0:
		animation.play("Run")		
func _ready():
	pass
func update(delta):
	pass
		
	
func enter():
	animation.play("Run")	
	print("blanbi")
	
func handle_input(event):
	pass

extends KinematicBody2D
var velocity = Vector2.ZERO
var shooting = false
var crouch = false
var aim_up = false
var aim
export (PackedScene) var Bullet

onready var sprite = $AnimatedSprite
func _ready():
	pass 
func _physics_process(delta):
	
	if velocity.y > 0 && shooting == false:
		#print(velocity.y)
		sprite.play("Fall")
	elif velocity.y < 0 && shooting == false:
		sprite.play("Jump")	
	elif is_on_floor():
		velocity.y = 0
		
	#aiming (if this seems confusing fuck you)
	if sprite.flip_h == false && aim == 1: #Aim 1 = STANDING
		$Muzzle.position.x = 6.259
		$Muzzle.position.y = 4.544
		$Muzzle.rotation_degrees = 0
	elif sprite.flip_h == true && aim == 1:
		$Muzzle.position.x = -6.441
		$Muzzle.position.y = 4.544
		$Muzzle.rotation_degrees = -180
	elif sprite.flip_h == false && aim == 2: #Aim 2 = AIM UP
		$Muzzle.position.x = -3.563
		$Muzzle.position.y = -4.782
		$Muzzle.rotation_degrees = -90
	elif sprite.flip_h == true && aim == 2:
		$Muzzle.position.x = 3.481
		$Muzzle.position.y = -4.782
		$Muzzle.rotation_degrees = -90	
	elif sprite.flip_h == false && aim == 3: #Aim 3 = GUN DOWN FALL
		$Muzzle.position.x = -1.522
		$Muzzle.position.y = 15.448
		$Muzzle.rotation_degrees = 90		
	elif sprite.flip_h == true && aim == 3:
		$Muzzle.position.x = 1.525
		$Muzzle.position.y = 15.448
		$Muzzle.rotation_degrees = 90	
	elif sprite.flip_h == false && aim == 4: #Aim 4 = CROUCH G
		$Muzzle.position.x = 6.259
		$Muzzle.position.y = 7.539
		$Muzzle.rotation_degrees = 0	
	elif sprite.flip_h == true && aim == 4:
		$Muzzle.position.x = -6.441
		$Muzzle.position.y = 7.539
		$Muzzle.rotation_degrees = -180				
func shoot():
		var b = Bullet.instance()
		owner.add_child(b)
		b.transform = $"Muzzle".global_transform
		$"Muzzle/AudioStreamPlayer2D".play()

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

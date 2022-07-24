extends KinematicBody2D
var velocity = Vector2.ZERO
var shooting = false
var crouch = false
var aim_up = false
var aim
var smoke = false
var dead = false
onready var particles = $"Particles2D"
onready var gun_tween = $"../CanvasLayer/Control/Gun/GunBar/Tween"
onready var muzzle = $Muzzle
var rng = RandomNumberGenerator.new()
export (PackedScene) var Bullet
export (PackedScene) var death_sc
onready var tween = $Tween
onready var sprite = $AnimatedSprite

func _ready():
	$"Hit".play("Hit")
func _process(delta):
	if gun_tween.is_active():
		particles.emitting = true
		if smoke == false:
			$"Particles2D/AudioStreamPlayer2D".play()
			smoke = true
	elif !gun_tween.is_active():
		particles.emitting = false	
	if shooting == false:
		particles.emitting = false
		
	particles.position.x = muzzle.position.x
	particles.position.y = muzzle.position.y
	
func _physics_process(delta):
	if dead == true:
		velocity.y = 0
	if velocity.y > 0 && shooting == false:
		#print(velocity.y)
		sprite.play("Fall")
	elif velocity.y < 0 && shooting == false:
		sprite.play("Jump")	
	elif is_on_floor():
		velocity.y = 0
		
	#aiming (if this seems confusing fuck you)
	if sprite.flip_h == false && aim == 1: #Aim 1 = STANDING
		muzzle.position.x = 6.259
		muzzle.position.y = 4.544
		muzzle.rotation_degrees = 0
	elif sprite.flip_h == true && aim == 1:
		muzzle.position.x = -6.441
		muzzle.position.y = 4.544
		muzzle.rotation_degrees = -180
	elif sprite.flip_h == false && aim == 2: #Aim 2 = AIM UP
		muzzle.position.x = -3.563
		muzzle.position.y = -4.782
		muzzle.rotation_degrees = -90
	elif sprite.flip_h == true && aim == 2:
		muzzle.position.x = 3.481
		muzzle.position.y = -4.782
		muzzle.rotation_degrees = -90	
	elif sprite.flip_h == false && aim == 3: #Aim 3 = GUN DOWN FALL
		muzzle.position.x = -1.522
		muzzle.position.y = 15.448
		muzzle.rotation_degrees = 90		
	elif sprite.flip_h == true && aim == 3:
		muzzle.position.x = 1.525
		muzzle.position.y = 15.448
		muzzle.rotation_degrees = 90	
	elif sprite.flip_h == false && aim == 4: #Aim 4 = CROUCH G
		muzzle.position.x = 6.259
		muzzle.position.y = 7.539
		muzzle.rotation_degrees = 0	
	elif sprite.flip_h == true && aim == 4:
		muzzle.position.x = -6.441
		muzzle.position.y = 7.539
		muzzle.rotation_degrees = -180				
func shoot():
	shooting = true
	if !gun_tween.is_active() && dead == false:
		var b = Bullet.instance()
		owner.add_child(b)
		b.transform = $"Muzzle".global_transform
		$"Muzzle/AudioStreamPlayer2D".play()
		$"../CanvasLayer/Control/Gun/GunBar".value = $"../CanvasLayer/Control/Gun/GunBar".value + 1
		
# Old gravityt and movement system, keeping here for reference
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

func death():
	dead = true
	$"../CanvasLayer/Control".visible = false
	$"AnimatedSprite".playing = false
	$"AnimatedSprite/ColorRect/Screen Dark".play("Screen")
	print($"AnimatedSprite/ColorRect/Screen Dark".is_playing())
	tween.interpolate_property($".", "position",
		self.global_position, $"../Camera2D".global_position + Vector2(0, -50), 2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	$"CollisionShape2D".disabled = true
	
func hit():
	$"Hit".play("Hit")
	rng.randomize()
	$"Hit/Hit_sound".pitch_scale = rng.randf_range(0.5, 1.5)
	$"Hit/Hit_sound".play()
	if $"../CanvasLayer/Control/Health Bar/Health Bar".value <= 0:
		death()


#STRIKES beginning

func _on_Skelly_strike():
	$"../CanvasLayer/Control/Health Bar/Health Bar".value = $"../CanvasLayer/Control/Health Bar/Health Bar".value - 1
	hit()
func _on_Slimey_strike():
	$"../CanvasLayer/Control/Health Bar/Health Bar".value = $"../CanvasLayer/Control/Health Bar/Health Bar".value - 1
	hit()
	print("konk")
#STRIKES end


func _on_AudioStreamPlayer2D_finished():
	smoke = false
	#This smoke variable ensures the smoke sound plays only once, YES it is spaghetti code, but come on...


func _on_Tween_tween_completed(object, key):
	$"Death".play("Death")


func _on_Death_animation_finished(anim_name):
	var d = death_sc.instance()
	owner.add_child(d)
	d.global_position = self.global_position
	#get_tree().change_scene("res://HUD elements/Death Screen/Death_Screen.tscn")



	

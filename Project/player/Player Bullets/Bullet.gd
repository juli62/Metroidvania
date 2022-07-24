extends Area2D

export var speed = 900
func _physics_process(delta):
	position += transform.x * speed * delta


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"AnimatedSprite/Light2D".enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	$"AudioStreamPlayer2D".play()
	$AnimatedSprite.play("boom")
	speed = 0
	$"AnimatedSprite/Light2D".enabled = false
		
	if body.is_in_group("skelly"):
		body.death()




func _on_AudioStreamPlayer2D_finished():
	pass

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "boom":
		queue_free()

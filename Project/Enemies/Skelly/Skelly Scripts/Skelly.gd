extends KinematicBody2D
export (PackedScene) var SkellyH
var motion = Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	motion.y = 918
	motion.x = -50
	move_and_collide(motion)

func _physics_process(delta):
	
	move_and_slide(motion)
	if motion.x > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	if motion.x != 0:
		$AnimatedSprite.play("Walk")	

func death():
	motion.x = 0 
	$AnimatedSprite.play("Dead")	
	$"CollisionShape2D".free()
	motion.y = 0
	head()
func head():
	var h = SkellyH.instance()
	owner.add_child(h)
	h.transform = $"Head".global_transform		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dead":
		pass
	

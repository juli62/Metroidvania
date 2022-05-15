extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../AnimatedSprite".flip_h == true:
		self.rotation_degrees = 90
	elif $"../AnimatedSprite".flip_h == false:
		self.rotation_degrees = -90

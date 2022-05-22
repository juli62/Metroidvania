extends "res://StateMachine/State.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func enter():
	$"../Idle".attack = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../Idle".attack == true && owner.Dead == false:
		$"../../AnimatedSprite".play("Attack")
	if $"../../AnimatedSprite".animation == "Attack" && $"../../AnimatedSprite".frame == 2:
		#print("Dankinkolkul")
		$"../..".emit_signal("strike")

func _on_Range_body_exited(body):
	if body.name == "Player" && owner.Dead == false:
		emit_signal("finished", "Chasing")
		$"../Idle".attack = false
	

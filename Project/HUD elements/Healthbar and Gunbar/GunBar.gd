extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../../Light2D/AnimationPlayer".play("Battery")


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_GunBar_value_changed(value):
	if (value >= 6):
		$Tween.interpolate_property(self, "value", 6, 0, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()	



#Old way of doing it, leaving it here as a reminder of the usefulnes of the return function

#func _on_GunBar_value_changed(value):
#	if (value < 6):
#		return
#	$Tween.interpolate_property(self, "value", 6, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	$Tween.start()	


func _on_Health_Bar_value_changed(value):
	$"../../Heart/AnimationPlayer".play("Hit")

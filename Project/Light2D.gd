extends Light2D

onready var noise = OpenSimplexNoise.new()
var value = 0.0
const MAX_VALUE = 10000000
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	value = randi()%MAX_VALUE
	noise.period = 16
func _physics_process(delta):
	value += 1
	if (value > MAX_VALUE):
		value = 0.0
	var alpha = ((noise.get_noise_1d(value) + 1) / 4.0) + 0.5
	self.color = Color(color.r, color.g, color.b, alpha)		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

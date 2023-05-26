extends Area2D

var position_last = Vector2()
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_viewport().get_mouse_position()
	
	velocity = 1/delta * (position - position_last)
	
	position_last = position
	
	$DebugLabel.text = str(velocity.length())


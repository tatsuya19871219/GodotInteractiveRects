extends Area2D

signal hit(rect)

var rotate_direction : int = 0
@export var rotate_speed : float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_size(size):
	scale = size/$ColorRect.size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _on_mouse_entered():
#	pass # Replace with function body.

func _on_color_rect_mouse_entered():
	var mouse_position = get_viewport().get_mouse_position()
	var distance = (mouse_position - position).length()
	$DebugLabel.text = str(distance)
	hit.emit(self)

func rotate_for_a_while(direction):
	
	rotate_direction = direction
	
	if($RotateTimer.is_stopped()):
		$RotateTimer.start()
	
	await get_tree().create_timer(1.0).timeout
	
	$RotateTimer.stop()
	
	# Reset the angle
	rotation = 0.0
	rotate_direction = 0
	

func _on_rotate_timer_timeout():
	rotate(rotate_direction*rotate_speed*PI)

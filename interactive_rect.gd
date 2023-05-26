extends Area2D

signal hit(rect)

#@export var rect_size : Vector2 
#var screen_size # Size of the game window.

var rotate_direction : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#screen_size = get_viewport_rect().size
	#$ColorRect.size = rect_size
	#$ColorRect.position = -rect_size/2
	#$ColorRect.scale = rect_size/$ColorRect.size
	pass
	
func set_size(size):
#	$ColorRect.size = size
#	$ColorRect.position = -size/2
#	$ColorRect/CenterMarker.size = 0.2*size
#	$ColorRect/CenterMarker.position = -0.2*size/2
	scale = size/$ColorRect.size
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	rotate(0.1*PI * delta)
	pass


func _on_mouse_entered():
	pass # Replace with function body.


func _on_color_rect_mouse_entered():
	var mouse_position = get_viewport().get_mouse_position()
	var distance = (mouse_position - position).length()
	#$DebugLabel.text = str(distance)
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
	rotate(rotate_direction*0.2*PI)

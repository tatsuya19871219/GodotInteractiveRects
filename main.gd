extends Node

@export var rect_size : Vector2
@export var spacing_ratio : float
@export var rect_scene : PackedScene
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	generate_rects()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_rects():
	
	var offset = rect_size/2
	var spacing = spacing_ratio*rect_size
	var margin_x = fmod(screen_size.x+spacing.x, rect_size.x+spacing.x) / 2
	var margin_y = fmod(screen_size.y+spacing.y, rect_size.y+spacing.y) / 2
	var drawing_x = screen_size.x - 2*margin_x
	var drawing_y = screen_size.y - 2*margin_y
	var counts_x = int((drawing_x+spacing.x)/(rect_size.x + spacing.x))
	var counts_y = int((drawing_y+spacing.y)/(rect_size.y + spacing.y))
	
	for i in range(counts_x):
		for j in range(counts_y):
			var rect = rect_scene.instantiate()
			
			#rect.rect_size = rect_size
			rect.set_size(rect_size)

			var x = offset.x + margin_x + i*(rect_size.x + spacing.x)
			var y = offset.y + margin_y + j*(rect_size.y + spacing.y)
			rect.position = Vector2(x, y)
			
			rect.connect("hit", hit_rect)

			add_child(rect)
	
#	var rect = rect_scene.instantiate()
#	rect.position = screen_size/2
#	add_child(rect)

func hit_rect(rect):
	
	var distance = $Cursor.position - rect.position
	
	var transition = distance + $Cursor.velocity
	
	var direction = sign(Vector3(distance.x, distance.y, 0).cross(Vector3(transition.x, transition.y, 0)).z)
	
	rect.rotate_for_a_while(direction)

func _on_debug_timer_timeout():
	#$DebugLabel.text = str(get_viewport().get_mouse_position())
	$DebugLabel.text = str($Cursor.velocity.length())

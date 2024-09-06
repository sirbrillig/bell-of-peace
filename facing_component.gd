extends Node2D
class_name FacingComponent

var _facing: int = RIGHT
const LEFT = -1
const RIGHT = 1

func get_facing():
	return _facing
	
func set_facing(direction: int):
	if direction != RIGHT and direction != LEFT:
		assert(false, "cannot set facing to anything except -1 or 1")
	if direction == RIGHT and _facing == LEFT:
		flip_character_side()
	if direction == LEFT and _facing == RIGHT:
		flip_character_side()
	_facing = direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func flip_character_side():
	# Note that setting scale.x to -1 just flips the orientation 
	# but does not permanently change scale.x!
	get_parent().scale.x = -1

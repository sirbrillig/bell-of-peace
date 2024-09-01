extends Node2D
class_name FacingComponent

var facing: int = RIGHT
const LEFT = 0
const RIGHT = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Note that setting scale.x to -1 just flips the orientation 
	# but does not permanently change scale.x!
	if get_parent().velocity.x < 0 and facing != LEFT:
		flip_character_side()
	if get_parent().velocity.x > 0 and facing != RIGHT:
		flip_character_side()	

	if get_parent().velocity.x > 0:
		facing = RIGHT
	if get_parent().velocity.x < 0:
		facing = LEFT
		
func flip_character_side():
	get_parent().scale.x = -1

extends Node2D
class_name GravityComponent

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height ) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height ) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	get_parent().velocity.y += calc_gravity() * delta

func calc_gravity() -> float:
	if get_parent().velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity
		
func jump() -> void:
	get_parent().velocity.y = jump_velocity

extends Node2D
class_name HitPointsComponent

@export var starting_hp: int = 1
var total_hp: int
var current_hp: int

func _ready() -> void:
	total_hp = starting_hp
	current_hp = total_hp

func damage(amount: int) -> void:
	current_hp -= amount
	if current_hp < 1:
		get_parent().queue_free()

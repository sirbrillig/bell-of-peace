extends Node2D
class_name HitPointsComponent

@export var facing_component: FacingComponent
@export var starting_hp: int = 1
var total_hp: int
var current_hp: int

func _ready() -> void:
	total_hp = starting_hp
	current_hp = total_hp

func damage(amount: int, direction: int) -> void:
	current_hp -= amount
	get_parent().is_being_hit = true
	knockback(direction)
	
func knockback(direction: int) -> void:
	get_parent().velocity.x = -400 if direction == facing_component.LEFT else 400
	await get_tree().create_timer(0.1).timeout
	get_parent().velocity.x = 0

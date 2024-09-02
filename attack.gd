extends State
class_name Attack

@export var enemy: Mob
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")


func enter():
	enemy.is_attacking = true
	
func exit():
	enemy.is_attacking = false
	

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.has_method("damage"):
		area.damage(1)

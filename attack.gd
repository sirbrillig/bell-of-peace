extends State
class_name Attack

@export var enemy: Mob
@export var animation: AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")


func update(_delta):
	if animation.frame > 2:
		enemy.is_attacking = true
	
func exit():
	enemy.is_attacking = false
	

func _on_attack_area_area_entered(area) -> void:
	if area is HitPointsComponent:
		area.damage(1)

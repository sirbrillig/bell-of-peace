extends State
class_name ChasePlayer

@export var speed: float
@export var attack_range: float
@export var aware_distance: float
@export var enemy: CharacterBody2D

var player_position: Vector2
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
 
func physics_update(_delta: float) -> void:
	player_position = player.position
	var distance_to_player = enemy.position.distance_to(player_position)
	if distance_to_player > attack_range and distance_to_player < aware_distance:
		move_toward_player()
	else:
		enemy.velocity.x = 0	

	
func move_toward_player() -> void:
	enemy.velocity.x = (enemy.position.direction_to(player_position) * speed).x

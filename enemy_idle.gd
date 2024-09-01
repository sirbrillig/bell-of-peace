extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var next_state_range: float
@export var next_state: State

var player_position: Vector2
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func enter():
	enemy.velocity.x = 0;
	
func update(_delta: float):
	player_position = player.position
	var distance_to_player = enemy.position.distance_to(player_position)
	if distance_to_player < next_state_range:
		state_changed.emit(self, next_state.name)

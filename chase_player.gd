extends State
class_name ChasePlayer

@export var facing_component: FacingComponent
@export var speed: float
@export var attack_range: float
@export var aware_range: float
@export var enemy: CharacterBody2D
@export var attack_state: State
@export var unaware_state: State

var player_position: Vector2
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func exit():
	enemy.velocity.x = 0;
 
func physics_update(_delta: float) -> void:
	player_position = player.position
	var distance_to_player = enemy.position.distance_to(player_position)
	if distance_to_player > aware_range:
		state_changed.emit(self, unaware_state.name)
		return
	if distance_to_player < attack_range:
		state_changed.emit(self, attack_state.name)
		return
	move_toward_player()
	
func move_toward_player() -> void:
	var direction = enemy.position.direction_to(player_position)
	enemy.velocity.x = (direction * speed).x
	if facing_component:
		facing_component.set_facing(facing_component.LEFT if direction.x < 0 else facing_component.RIGHT)

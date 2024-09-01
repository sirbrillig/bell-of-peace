extends CharacterBody2D

@export var speed: float
@export var attack_range: float
@export var aware_distance: float
var player_position: Vector2
@onready var player: CharacterBody2D = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
	else:
		$AnimatedSprite2D.animation = "idle"

func _physics_process(delta: float) -> void:
	player_position = player.position
	var distance_to_player = position.distance_to(player_position)
	if distance_to_player > attack_range and distance_to_player < aware_distance:
		move_toward_player()
	else:
		velocity.x = 0	
	if is_on_wall():
		$GravityComponent.jump()
	
	move_and_slide()
	
func move_toward_player() -> void:
	velocity.x = (position.direction_to(player_position) * speed).x

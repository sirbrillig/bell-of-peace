extends CharacterBody2D

@export var speed: float
@export var attack_range: float
@export var aware_distance: float
var player_position: Vector2
@onready var player: CharacterBody2D = get_node("../Player")

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height ) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height ) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func calc_gravity() -> float:
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity

func jump() -> void:
	velocity.y = jump_velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "idle"

func _physics_process(delta: float) -> void:
	player_position = player.position
	var distance_to_player = position.distance_to(player_position)
	if distance_to_player > attack_range and distance_to_player < aware_distance:
		move_toward_player()
	else:
		velocity.x = 0
	velocity.y += calc_gravity() * delta
	
	if is_on_wall():
		jump()
	
	move_and_slide()
	
func move_toward_player() -> void:
	velocity.x = (position.direction_to(player_position) * speed).x

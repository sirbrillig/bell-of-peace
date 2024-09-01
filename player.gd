extends CharacterBody2D
@export var speed = 100
@export var jump_speed = -400
@export var gravity = 30


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "idle"

func _physics_process(delta: float) -> void:
	if ! is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0
	
	var direction_h = Input.get_axis("ui_left", "ui_right")
	velocity.x = speed * direction_h
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_speed
		
	move_and_slide()

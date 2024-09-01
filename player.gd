extends CharacterBody2D
@export var speed: float

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
	var direction_h = Input.get_axis("ui_left", "ui_right")
	velocity.x = speed * direction_h
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		$GravityComponent.jump()
	
	move_and_slide()

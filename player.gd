extends CharacterBody2D
class_name Player

@export var speed: float

var is_being_hit: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_being_hit and ! $AnimatedSprite2D.is_playing():
		is_being_hit = false
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
		
	if is_being_hit:
		$AnimatedSprite2D.animation = "hurt"
		return
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		return
	$AnimatedSprite2D.animation = "idle"

func _physics_process(_delta: float) -> void:
	if is_being_hit:
		move_and_slide()
		return
	
	var direction_h = Input.get_axis("ui_left", "ui_right")
	velocity.x = speed * direction_h
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		$GravityComponent.jump()
	
	if velocity.y < -300:
		#FIXME: IDK what causes this
		assert(false, "what hit me")
	move_and_slide()

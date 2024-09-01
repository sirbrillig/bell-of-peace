extends CharacterBody2D
class_name Mob

var is_attacking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_attacking:
		$AnimatedSprite2D.animation = "attack"
		$AttackArea/AttackShape.set_deferred("disabled", false)
		return
	$AttackArea/AttackShape.set_deferred("disabled", true)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		return
	$AnimatedSprite2D.animation = "idle"

func _physics_process(_delta: float) -> void:
	if is_on_wall():
		$GravityComponent.jump()
	move_and_slide()

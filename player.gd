extends CharacterBody2D
class_name Player

@export var speed: float

var is_being_hit: bool = false
var is_healing: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	if is_being_hit:
		$AnimatedSprite2D.animation = "hurt"
		$AnimatedSprite2D.play()
		return
	if is_healing:
		$AnimatedSprite2D.animation = 'heal'
		$AnimatedSprite2D.play()
		return
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		return
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

func _physics_process(_delta: float) -> void:
	if is_being_hit:
		move_and_slide()
		return
	
	if is_healing:
		return
	
	var direction_h = Input.get_axis("ui_left", "ui_right")
	velocity.x = speed * direction_h
	
	if direction_h == 1:
		$FacingComponent.set_facing($FacingComponent.RIGHT)
	if direction_h == -1:
		$FacingComponent.set_facing($FacingComponent.LEFT)
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		$GravityComponent.jump()
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		heal()
	
	if velocity.y < -300:
		#FIXME: IDK what causes this
		assert(false, "what hit me")
	move_and_slide()

func heal():
	is_healing = true
	$HealPower.visible = true
	$HealPower.play()

func _on_animated_sprite_2d_animation_finished() -> void:
	if is_healing:
		is_healing = false
		$HealPower.visible = false
	if is_being_hit:
		is_being_hit = false

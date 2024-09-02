extends State
class_name Attack

@export var enemy: Mob
@export var attack_shape: CollisionShape2D
@export var animation: AnimatedSprite2D
@export var next_state: State
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")


func enter():
	enemy.is_attacking = true

func update(_delta):
	if enemy.is_attacking and animation.frame > 2:
		attack_shape.set_deferred("disabled", false)

func exit():
	enemy.is_attacking = false
	attack_shape.set_deferred("disabled", true)

func _on_attack_area_area_entered(area) -> void:
	if area is HitPointsComponent:
		area.damage(1)


func _on_animated_sprite_2d_animation_finished() -> void:
	if enemy.is_attacking:
		state_changed.emit(self, next_state.name)

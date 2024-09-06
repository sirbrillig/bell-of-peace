extends Area2D

@export var player: Player
var _touching_mob: Mob

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _touching_mob and player and player.is_healing:
		_touching_mob.touched_by_player()
		_touching_mob = null


func _on_body_entered(body) -> void:
	if body is Mob:
		_touching_mob = body


func _on_body_exited(body: Node2D) -> void:
	if body == _touching_mob:
		_touching_mob = null

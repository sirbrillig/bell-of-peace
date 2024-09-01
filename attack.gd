extends State
class_name Attack

@export var enemy: Mob

func enter():
	enemy.is_attacking = true
	
func exit():
	enemy.is_attacking = false
	

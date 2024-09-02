extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_changed.connect(on_child_state_changed)
	if initial_state:
		initial_state.enter()
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state and get_parent().is_healed():
		on_child_state_changed(current_state, "EnemyIdle")
		return
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_state_changed(prev_state: State, new_state_name: String) -> void:
	if prev_state != current_state:
		push_error("Received state change event from inactive state " + prev_state.name)
		return
	var new_state = states.get(new_state_name.to_lower())
	if ! new_state:
		assert(false, "Received state change event for nonexistent state " + new_state_name)
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state

extends Node

class_name JobOfferStateMachine

var current_state
var states: Dictionary

func _ready():
	current_state = get_node("NotMatched")
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.connect("transitioned", self, "on_child_transitioned")
		else:
			push_warning("State machine contains child which is not 'State'")
	current_state.enter()

func on_child_transitioned(new_state_name):
	var new_state = states.get(new_state_name)
	if new_state != null && new_state != current_state:
		current_state.exit()
		new_state.enter()
		current_state = new_state
	else:
		push_warning("Called transition on a state that does not exist")

func _process(delta):
	current_state.update(delta)
	
func _physics_process(delta):
	current_state.physics_update(delta)

extends StateMachine

class_name StateMachineCV


func _ready():
	current_state = get_node(initial_state)
	for child in get_children():
		if child is StateCV:
			states[child.name] = child
			child.connect("transitioned", self, "on_child_transitioned")
			child.cv = get_parent()
		else:
			push_warning("State machine contains child which is not 'State'")
	current_state.enter()

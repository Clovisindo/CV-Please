extends StateMachine

class_name StateMachineJobOffer

func _ready():
	current_state = get_node(initial_state)
	for child in get_children():
		if child is StateJobOffer:
			states[child.name] = child
			child.connect("transitioned", self, "on_child_transitioned")
		else:
			push_warning("State machine contains child which is not 'State'")
	current_state.enter()

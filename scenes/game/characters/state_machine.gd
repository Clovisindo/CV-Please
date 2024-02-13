extends StateMachine

class_name StateMachineApplicant

func _get_initial_state():
	return get_node("Waiting")

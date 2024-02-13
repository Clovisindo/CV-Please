extends StateMachine

class_name StateMachineJobOffer

func _get_initial_state():
	return get_node("NotMatched")

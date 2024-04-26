extends Node

class_name StateMachine

var states: Dictionary
export var initial_state: NodePath
var current_state


func on_child_transitioned(new_state_name):
	var new_state = states.get(new_state_name)
	if new_state != null && new_state != current_state:
		current_state.exit()
		new_state.enter()
		print("cambiando de estado: " + str(current_state) + " a " + str(new_state_name))
		current_state = new_state

	else:
		push_warning("Called transition on a state that does not exist")


func _process(delta):
	current_state.update(delta)


func _physics_process(delta):
	current_state.physics_update(delta)

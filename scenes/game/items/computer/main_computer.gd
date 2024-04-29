extends Button

class_name MainComputer

signal interaction_started
signal interaction_ended

var current_applicant: Applicant


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func applicant_selected(show: bool):
	if show:
		emit_signal("interaction_started", current_applicant)
	else:
		emit_signal("interaction_ended", current_applicant)


func load_applicant_computer(_applicant):
	current_applicant = _applicant
	$StateMachine.current_state.active_main_computer()


func unload_applicant_computer():
	$StateMachine.current_state.disable_main_computer()

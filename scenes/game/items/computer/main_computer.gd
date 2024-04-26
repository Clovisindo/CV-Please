extends Button

class_name MainComputer

var current_applicant: Applicant

signal interaction_started
signal interaction_ended


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func _applicant_selected(show: bool):
	if show:
		emit_signal("interaction_started", current_applicant)
	else:
		emit_signal("interaction_ended", current_applicant)


func _load_applicant_computer(_applicant):
	current_applicant = _applicant
	$StateMachine.current_state._active_main_computer()


func _unload_applicant_computer():
	$StateMachine.current_state._disable_main_computer()

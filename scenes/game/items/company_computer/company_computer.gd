extends Button

class_name CompanyComputer

signal show_computer_validation
signal end_computer_validation



func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func _applicant_selected(show: bool):
	if show:
		emit_signal("show_computer_validation")
	else:
		emit_signal("end_computer_validation")


func _load_company_computer():
	$StateMachine.current_state._active_company_computer()


func _unload_company_computer():
	$StateMachine.current_state._disable_company_computer()


extends Button

class_name CompanyComputer

signal show_computer_validation
signal end_computer_validation

var event_fired = false


func _ready() -> void:
	$StateMachine.init(self)


func _gui_input(event):
	if !event_fired:
		$StateMachine.current_state.handle_input(event)


func applicant_selected(show: bool):
	event_fired = true
	set_process_unhandled_input(false)
	if show:
		emit_signal("show_computer_validation")
	else:
		emit_signal("end_computer_validation")


func load_company_computer():
	$StateMachine.current_state.active_company_computer()


func unload_company_computer():
	$StateMachine.current_state.disable_company_computer()

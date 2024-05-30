extends Button

class_name CompanyComputer

signal show_computer_validation
signal end_computer_validation

enum PanelStatus {
	OPEN,
	CLOSED,
}

var event_fired = false
var mouse_over = false


func _ready() -> void:
	$StateMachine.init(self)


func _on_CompanyComputerButton_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if !event_fired:
			event_fired = true
			$StateMachine.current_state.handle_input(event)


func applicant_selected(show: bool):
	set_process_unhandled_input(false)
	if show:
		emit_signal("show_computer_validation")
	else:
		emit_signal("end_computer_validation")


func load_company_computer():
	$StateMachine.current_state.active_company_computer()


func unload_company_computer():  #sea como sea antes de desactivar hay que volver a un estado aceptable para volver a inicia
	reset_to_reopen()
	$StateMachine.current_state.disable_company_computer()


func reset_to_reopen():
	if $StateMachine.current_state == $StateMachine/active:
		$StateMachine.current_state.show = false
		$StateMachine.current_state.current_status = PanelStatus.CLOSED


func _on_CompanyComputerButton_mouse_exited() -> void:
	mouse_over = false
	event_fired = false


func _on_CompanyComputerButton_mouse_entered() -> void:
	mouse_over = true

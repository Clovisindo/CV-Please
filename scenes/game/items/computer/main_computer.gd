extends Button

class_name MainComputer

signal interaction_started
signal interaction_ended

var current_applicant: Applicant
var mouse_over = false
var event_fired = false


func _on_MainComputerButton_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if !event_fired:
			event_fired = true
			$ButtonEffectSFX.playing = true
			$StateMachine.current_state.handle_input(event)


func applicant_selected(show: bool):
	set_process_unhandled_input(false)
	if show:
		emit_signal("interaction_started", current_applicant)
	else:
		emit_signal("interaction_ended", current_applicant)


func load_applicant_computer(_applicant):
	current_applicant = _applicant
	$StateMachine.current_state.active_main_computer()


func unload_applicant_computer():
	$StateMachine.current_state.disable_main_computer()


func _on_MainComputerButton_mouse_exited() -> void:
	mouse_over = false
	event_fired = false


func _on_MainComputerButton_mouse_entered() -> void:
	mouse_over = true

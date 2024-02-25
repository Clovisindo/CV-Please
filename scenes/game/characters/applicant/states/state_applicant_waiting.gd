extends StateApplicant

class_name StateApplicantWaiting


func handle_input(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("transitioned","Reviewing")


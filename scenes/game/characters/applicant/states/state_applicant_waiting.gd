extends StateApplicant

class_name StateApplicantWaiting


func handle_input(event:InputEvent):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("transitioned","Reviewing")
		applicant._load_applicant_computer()#emit signal al mainComputer para avanzar a estado activo 


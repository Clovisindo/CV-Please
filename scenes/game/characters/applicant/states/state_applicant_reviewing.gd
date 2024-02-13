extends StateApplicant

class_name StateApplicantReviewing

func enter():
	if portrait:
		portrait.flip_v = true
	if applicant:
		applicant.show_cv(true)

func exit():
	if portrait:
		portrait.flip_v = false
	if applicant:
		applicant.show_cv(false)

func handle_input(event: InputEvent):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("transitioned","Waiting")

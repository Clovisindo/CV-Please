extends StateApplicant

class_name StateApplicantReviewing

var velocity = 50
var y_limit = 10
var initial_y_pos = 0



func enter():
	initial_y_pos = portrait.position.y


func exit():
	var tween = create_tween().tween_property(portrait, "position:y", initial_y_pos, 1)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)


func handle_input(event: InputEvent):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("transitioned","Waiting")
		applicant._unload_applicant_computer()
		applicant._unload_company_computer()


func update(delta):
	# Si se ha salido del limite, cambiamos la direccion
	if portrait.position.y >= y_limit || portrait.position.y <= 0-y_limit:
		velocity *= -1
	portrait.position.y += velocity * delta


func process_applicant():
	emit_signal("transitioned","Animating")
	

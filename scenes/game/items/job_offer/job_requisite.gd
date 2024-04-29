extends Panel

class_name JobRequisite

enum JobOfferStatus {
	IDLE,
	SELECTED,
	MATCHED,
}

export(JobOfferStatus) var current_status

var requisite_answer: String
var requisite_question: String
var requisite_name: String
var job_offer: JobOffer

var velocity = -25
var x_limit = -10


func requisite_asked():
	current_status = JobOfferStatus.MATCHED
	rect_position.x = -10


func requisite_idle():
	if current_status == JobOfferStatus.SELECTED:
		current_status = JobOfferStatus.IDLE
		rect_position.x = 0


func add_data(text: String, question: String, answer: String):
	requisite_answer = answer
	requisite_question = question
	requisite_name = text
	$RequisiteText.text = text


func _gui_input(event):
	if current_status == JobOfferStatus.IDLE:
		_process_as_idle(event)
	elif current_status == JobOfferStatus.SELECTED:
		_process_as_selected(event)
	elif current_status == JobOfferStatus.MATCHED:
		_process_as_matched(event)


func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if job_offer:
			job_offer.requisite_checked(self)
		current_status = JobOfferStatus.SELECTED


func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		current_status = JobOfferStatus.IDLE
		rect_position.x = 0


func _process_as_matched(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process(delta):
	_set_size_by_text()
	if current_status == JobOfferStatus.SELECTED:
		if rect_position.x <= x_limit || rect_position.x >= 1:
			velocity *= -1
		rect_position.x += velocity * delta


func _set_size_by_text():
	get_node(".").rect_size.y = get_node("RequisiteText").rect_size.y + 8
	get_node(".").rect_min_size.y = get_node(".").rect_size.y

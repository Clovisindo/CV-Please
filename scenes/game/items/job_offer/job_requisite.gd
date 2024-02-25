extends Panel

class_name JobRequisite

var requisite_answer: String
var requisite_name: String
var job_offer: JobOffer

enum JobOfferStatus {
	IDLE,
	SELECTED,
	MATCHED,
}

export(JobOfferStatus) var current_status


func add_data(text: String, answer: String):
	requisite_answer = answer
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
			job_offer._requisite_checked(self)
		current_status = JobOfferStatus.SELECTED
		rect_position.x -= 10


func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		current_status = JobOfferStatus.IDLE
		rect_position.x = 0


func _process_as_matched(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass

extends Panel

class_name JobRequisite

signal send_cross_question

enum JobOfferStatus {
	IDLE,
	SELECTED,
	MATCHED,
	DISABLED,
	CROSS_IDLE,
	CROSS_IN_PROGRESS,
}

export(JobOfferStatus) var current_status

var requisite_answer: String
var requisite_question: String
var requisite_name: String
var job_offer: JobOffer

var previous_state

var velocity = -25
var x_limit = -10
var is_hovered = false


func add_data(text: String, question: String, answer: String):
	requisite_answer = answer
	requisite_question = question
	requisite_name = text
	$RequisiteText.text = text


func requisite_as_previous_state():
	match previous_state:
		JobOfferStatus.IDLE:
			_process_idle()
		JobOfferStatus.SELECTED:
			_process_selected()


func requisite_idle():
	if (
		current_status == JobOfferStatus.SELECTED
		|| current_status == JobOfferStatus.CROSS_IDLE
		|| current_status == JobOfferStatus.CROSS_IN_PROGRESS
	):
		_process_idle()


func _process_idle():
	current_status = JobOfferStatus.IDLE
	rect_position.x = 0
	$RequisiteText.add_color_override("default_color", Color(1, 1, 1, 1))


func requisite_selected():
	if current_status == JobOfferStatus.IDLE:
		_process_selected()


func _process_selected():
	current_status = JobOfferStatus.SELECTED
	$RequisiteText.add_color_override("default_color", Color(0, 0.392157, 0, 1))
	rect_position.x = 10


func requisite_disable():
	if current_status == JobOfferStatus.IDLE || current_status == JobOfferStatus.CROSS_IDLE:
		current_status = JobOfferStatus.DISABLED
		rect_position.x = 0


func requisite_enable():
	if current_status == JobOfferStatus.DISABLED:
		current_status = JobOfferStatus.IDLE
		rect_position.x = 0
		$RequisiteText.add_color_override("default_color", Color(1, 1, 1, 1))


func requisite_cross_idle():
	if (
		current_status == JobOfferStatus.IDLE
		|| current_status == JobOfferStatus.SELECTED
		|| current_status == JobOfferStatus.MATCHED
	):
		current_status = JobOfferStatus.CROSS_IDLE
		rect_position.x = 0
		$RequisiteText.add_color_override("default_color", Color(1, 0, 0, 1))


func requisite_cross_progress():
	if current_status == JobOfferStatus.CROSS_IDLE:
		current_status = JobOfferStatus.CROSS_IN_PROGRESS
		rect_position.x = 0
		$RequisiteText.add_color_override("default_color", Color(1, 1, 0, 1))


func check_is_status_cross_progress(requisite_status):
	if requisite_status == JobOfferStatus.CROSS_IN_PROGRESS:
		return true
	return false


func save_previous_state():
	previous_state = current_status


func _gui_input(event):
	if current_status == JobOfferStatus.IDLE:
		_process_as_idle(event)
	elif current_status == JobOfferStatus.SELECTED:
		_process_as_selected(event)
	elif current_status == JobOfferStatus.DISABLED:
		_process_as_disabled(event)
	elif current_status == JobOfferStatus.CROSS_IDLE:
		_process_as_cross_idle(event)
	elif current_status == JobOfferStatus.CROSS_IN_PROGRESS:
		_process_as_cross_processing(event)


func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if job_offer:
			job_offer.requisite_checked(self)
		current_status = JobOfferStatus.SELECTED
		$RequisiteText.add_color_override("default_color", Color(0, 0.392157, 0, 1))


func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process_as_disabled(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process_as_cross_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		current_status = JobOfferStatus.CROSS_IN_PROGRESS
		emit_signal("send_cross_question")


func _process_as_cross_processing(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process(delta):
	_set_size_by_text()
	if current_status == JobOfferStatus.IDLE && is_hovered:
		if rect_position.x <= x_limit || rect_position.x >= 1:
			velocity *= -1
		rect_position.x += velocity * delta


func _set_size_by_text():
	get_node(".").rect_size.y = get_node("RequisiteText").rect_size.y + 8
	get_node(".").rect_min_size.y = get_node(".").rect_size.y


func _on_RequisitePanel_mouse_exited() -> void:
	is_hovered = false


func _on_RequisitePanel_mouse_entered() -> void:
	is_hovered = true

extends Panel

class_name JobRequisite

enum JobOfferStatus {
	IDLE,
	SELECTED,
	MATCHED,
	DISABLED,
}

export(JobOfferStatus) var current_status

var requisite_answer: String
var requisite_question: String
var requisite_name: String
var job_offer: JobOffer

var velocity = -25
var x_limit = -10
var is_hovered = false


func requisite_asked():
	current_status = JobOfferStatus.MATCHED
	rect_position.x = 10


func requisite_idle():
	if current_status == JobOfferStatus.SELECTED:
		current_status = JobOfferStatus.IDLE
		rect_position.x = 0


func requisite_disable():
	if current_status == JobOfferStatus.IDLE:
		current_status = JobOfferStatus.DISABLED
		rect_position.x = 0


func requisite_enable():
	if current_status == JobOfferStatus.DISABLED:
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
	elif current_status == JobOfferStatus.DISABLED:
		_process_as_disabled(event)


func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if job_offer:
			job_offer.requisite_checked(self)
		current_status = JobOfferStatus.SELECTED
		$RequisiteText.add_color_override("default_color", Color(0, 0.392157, 0, 1))


func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process_as_matched(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process_as_disabled(event):
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

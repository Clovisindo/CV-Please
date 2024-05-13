extends Panel

class_name JobSpecialCondition

enum JobSpecialConditionStatus {
	IDLE,
	SELECTED,
	MATCHED,
	DISABLED,
}

export(JobSpecialConditionStatus) var current_status

export(EnumUtils.TypeSpecialCondition) var special_condition
var condition_name: String
var question_player: String
var response_applicant: String
var job_offer: JobOffer

var velocity = -25
var x_limit = -10
var is_hovered = false


func add_data(
	_special_condition,
	_condition_name: String,
	_question_player: String,
	_response_applicant: String
):
	special_condition = _special_condition
	condition_name = _condition_name
	question_player = _question_player
	response_applicant = _response_applicant
	$SpecialConditionRText.text = condition_name


func condition_idle():
	if current_status == JobSpecialConditionStatus.SELECTED:
		_process_idle()


func _process_idle():
	current_status = JobSpecialConditionStatus.IDLE
	rect_position.x = 0
	$SpecialConditionRText.add_color_override("default_color", Color(1, 1, 1, 1))


func requisite_selected():
	if current_status == JobSpecialConditionStatus.IDLE:
		_process_selected()


func _process_selected():
	current_status = JobSpecialConditionStatus.SELECTED
	$SpecialConditionRText.add_color_override("default_color", Color(0, 0.392157, 0, 1))
	rect_position.x = 10


func requisite_disable():
	if current_status == JobSpecialConditionStatus.IDLE:
		current_status = JobSpecialConditionStatus.DISABLED
		rect_position.x = 0


func requisite_enable():
	if current_status == JobSpecialConditionStatus.DISABLED:
		current_status = JobSpecialConditionStatus.IDLE
		rect_position.x = 0
		$SpecialConditionRText.add_color_override("default_color", Color(1, 1, 1, 1))


func save_previous_state():
	pass


func requisite_cross_idle():
	pass


func requisite_as_previous_state():
	pass


func check_is_status_cross_progress(value):
	return false


func _gui_input(event):
	if current_status == JobSpecialConditionStatus.IDLE:
		_process_as_idle(event)
	elif current_status == JobSpecialConditionStatus.SELECTED:
		_process_as_selected(event)
	elif current_status == JobSpecialConditionStatus.DISABLED:
		_process_as_disabled(event)


func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if job_offer:
			job_offer.condition_checked(self)
		current_status = JobSpecialConditionStatus.SELECTED
		$SpecialConditionRText.add_color_override("default_color", Color(0, 0.392157, 0, 1))


func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process_as_disabled(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process(delta):
	_set_size_by_text()
	if current_status == JobSpecialConditionStatus.IDLE && is_hovered:
		if rect_position.x <= x_limit || rect_position.x >= 1:
			velocity *= -1
		rect_position.x += velocity * delta


func _set_size_by_text():
	get_node(".").rect_size.y = get_node("SpecialConditionRText").rect_size.y + 8
	get_node(".").rect_min_size.y = get_node(".").rect_size.y


func _on_RequisitePanel_mouse_exited() -> void:
	is_hovered = false


func _on_RequisitePanel_mouse_entered() -> void:
	is_hovered = true

extends Panel

class_name SkillPanel

signal send_cross_question

enum SkillStatus {
	IDLE,
	SELECTED,
	MATCHED,
	DISABLED,
	CROSS_IDLE,
	CROSS_IN_PROGRESS,
}

export(SkillStatus) var current_status

var skill_answer: String
var skill_question: String
var skill_name: String
var cv: Curriculum

var previous_state

var velocity = 25
var x_limit = 10
var is_hovered = false


func add_data(text: String, question: String, answer: String):
	skill_answer = answer
	skill_question = question
	skill_name = text
	$SkillText.text = text


func skill_as_previous_state():
	match previous_state:
		SkillStatus.IDLE:
			_process_idle()
		SkillStatus.SELECTED:
			_process_selected()


func skill_idle():
	if (
		current_status == SkillStatus.SELECTED
		|| current_status == SkillStatus.CROSS_IDLE
		|| current_status == SkillStatus.CROSS_IN_PROGRESS
	):
		_process_idle()


func _process_idle():
	current_status = SkillStatus.IDLE
	rect_position.x = 0
	$SkillText.add_color_override("default_color", Color(1, 1, 1, 1))


func skill_disable():
	if current_status == SkillStatus.IDLE || current_status == SkillStatus.CROSS_IDLE:
		current_status = SkillStatus.DISABLED
		rect_position.x = 0


func skill_selected():
	if current_status == SkillStatus.IDLE:
		_process_selected()


func _process_selected():
	current_status = SkillStatus.SELECTED
	$SkillText.add_color_override("default_color", Color(0, 0.392157, 0, 1))
	rect_position.x = 10


func skill_enable():
	if current_status == SkillStatus.DISABLED:
		current_status = SkillStatus.IDLE
		rect_position.x = 0
		$SkillText.add_color_override("default_color", Color(1, 1, 1, 1))


func skill_cross_idle():
	if (
		current_status == SkillStatus.IDLE
		|| current_status == SkillStatus.SELECTED
		|| current_status == SkillStatus.MATCHED
	):
		current_status = SkillStatus.CROSS_IDLE
		rect_position.x = 0
		$SkillText.add_color_override("default_color", Color(1, 0, 0, 1))


func skill_cross_progress():
	if current_status == SkillStatus.CROSS_IDLE:
		current_status = SkillStatus.CROSS_IN_PROGRESS
		rect_position.x = 10
		$SkillText.add_color_override("default_color", Color(1, 1, 0, 1))


func check_is_status_cross_progress(skill_status):
	if skill_status == SkillStatus.CROSS_IN_PROGRESS:
		return true
	return false


func save_previous_state():
	previous_state = current_status


func _gui_input(event):
	if current_status == SkillStatus.IDLE:
		_process_as_idle(event)
	elif current_status == SkillStatus.SELECTED:
		_process_as_selected(event)
	elif current_status == SkillStatus.DISABLED:
		_process_as_disabled(event)
	elif current_status == SkillStatus.CROSS_IDLE:
		_process_as_cross_idle(event)
	elif current_status == SkillStatus.CROSS_IN_PROGRESS:
		_process_as_cross_processing(event)


func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		current_status = SkillStatus.SELECTED
		$SkillText.add_color_override("default_color", Color(0, 0.392157, 0, 1))
		if cv:
			cv.skill_checked(self)
			$ButtonEffectSFX.playing = true


func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process_as_disabled(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process_as_cross_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		skill_cross_progress()
		$ButtonEffectSFX.playing = true
		emit_signal("send_cross_question")


func _process_as_cross_processing(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


func _process(delta):
	_set_size_by_text()
	if (
		(current_status == SkillStatus.IDLE || current_status == SkillStatus.CROSS_IDLE)
		&& is_hovered
	):
		if rect_position.x >= x_limit || rect_position.x <= -1:
			velocity *= -1
		rect_position.x += velocity * delta


func _set_size_by_text():
	get_node(".").rect_size.y = get_node("SkillText").rect_size.y + 8
	get_node(".").rect_min_size.y = get_node(".").rect_size.y


func _on_SkillPanel_mouse_exited() -> void:
	is_hovered = false


func _on_SkillPanel_mouse_entered() -> void:
	is_hovered = true

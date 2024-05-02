extends Panel

class_name SkillPanel

enum SkillStatus {
	IDLE,
	SELECTED,
	MATCHED,
	DISABLED,
}

export(SkillStatus) var current_status

var skill_answer: String
var skill_question: String
var skill_name: String
var cv: Curriculum
var velocity = 25
var x_limit = 10


func add_data(text: String, question: String, answer: String):
	skill_answer = answer
	skill_question = question
	skill_name = text
	$SkillText.text = text


func skill_asked():
	current_status = SkillStatus.MATCHED
	rect_position.x = 10


func skill_idle():
	if current_status == SkillStatus.SELECTED:
		current_status = SkillStatus.IDLE
		rect_position.x = 0

func skill_disable():
	if current_status == SkillStatus.IDLE:
		current_status = SkillStatus.DISABLED
		rect_position.x = 0


func skill_enable():
	if current_status == SkillStatus.DISABLED:
		current_status = SkillStatus.IDLE
		rect_position.x = 0


func _gui_input(event):
	if current_status == SkillStatus.IDLE:
		_process_as_idle(event)
	elif current_status == SkillStatus.SELECTED:
		_process_as_selected(event)
	elif current_status == SkillStatus.MATCHED:
		_process_as_matched(event)
	elif current_status == SkillStatus.DISABLED:
		_process_as_disabled(event)


func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		current_status = SkillStatus.SELECTED
		$SkillText.add_color_override("default_color", Color( 0, 0.392157, 0, 1 ))
		if cv:
			cv.skill_checked(self)


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
	if current_status == SkillStatus.SELECTED:
		if rect_position.x >= x_limit || rect_position.x <= -1:
			velocity *= -1
		rect_position.x += velocity * delta


func _set_size_by_text():
	get_node(".").rect_size.y = get_node("SkillText").rect_size.y + 8
	get_node(".").rect_min_size.y = get_node(".").rect_size.y

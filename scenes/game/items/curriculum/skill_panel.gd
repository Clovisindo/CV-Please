extends Panel

class_name SkillPanel

export(PackedScene) var curriculumNode

var skill_answer: String
var cv: Curriculum

enum SkillStatus {
	IDLE,
	SELECTED,
	MATCHED,
}

export(SkillStatus) var current_status

func initialize(applicant_cv: Curriculum, text: String, answer: String):
	cv = applicant_cv
	skill_answer = answer
	$SkillText.text = text

func _gui_input(event):
	if current_status == SkillStatus.IDLE:
		_process_as_idle(event)
	elif current_status == SkillStatus.SELECTED:
		_process_as_selected(event)
	elif current_status == SkillStatus.MATCHED:
		_process_as_matched(event)

func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if cv:
			cv.skill_checked(self)
		current_status = SkillStatus.SELECTED
		rect_position.x += 10

func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		current_status = SkillStatus.IDLE
		rect_position.x = 0

func _process_as_matched(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass


extends Panel

class_name SkillPanel

export(PackedScene) var curriculumNode

var skill_text: String
var skill_answer: String
var cv: Curriculum

func initialize(applicant_cv: Curriculum, text: String, answer: String):
	cv = applicant_cv
	skill_answer = answer
	$SkillText.text = text

func _gui_input(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		cv.skill_checked(self)

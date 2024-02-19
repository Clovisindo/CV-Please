extends Panel

var requisite_answer
var job_offer: JobOffer

enum SkillStatus {
	IDLE,
	SELECTED,
	MATCHED,
}

export(SkillStatus) var current_status

func initialize(matrix_job_offer: JobOffer, text: String, answer: String):
	job_offer = matrix_job_offer
	requisite_answer = answer
	$RequisiteText.text = text

func _gui_input(event):
	if current_status == SkillStatus.IDLE:
		_process_as_idle(event)
	elif current_status == SkillStatus.SELECTED:
		_process_as_selected(event)
	elif current_status == SkillStatus.MATCHED:
		_process_as_matched(event)

func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if job_offer:
			job_offer.requisite_checked(self)
		current_status = SkillStatus.SELECTED
		rect_position.x -= 10

func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		current_status = SkillStatus.IDLE
		rect_position.x = 0

func _process_as_matched(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass

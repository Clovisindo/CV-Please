extends Panel

var requisite_answer
var job_offer: JobOffer

enum SkillStatus {
	idle,
	selected,
	matched
}

export(SkillStatus) var current_status

func _instantiate_signal_job_requisite(jobNode):
	self.connect("mouse_entered",jobNode,"_on_panel_mouse_entered")
	self.connect("mouse_exited",jobNode,"_on_panel_mouse_exited")
	self.connect("gui_input",jobNode,"_on_job_requisite_panel_gui_input",[requisite_answer])


func initialize(matrix_job_offer: JobOffer, text: String, answer: String):
	job_offer = matrix_job_offer
	requisite_answer = answer
	$RequisiteText.text = text

func _gui_input(event):
	if current_status == SkillStatus.idle:
		_process_as_idle(event)
	elif current_status == SkillStatus.selected:
		_process_as_selected(event)
	elif current_status == SkillStatus.matched:
		_process_as_matched(event)

func _process_as_idle(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if job_offer:
			job_offer.requisite_checked(self)
		current_status = SkillStatus.selected
		rect_position.x -= 10

func _process_as_selected(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		current_status = SkillStatus.idle
		rect_position.x = 0

func _process_as_matched(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass

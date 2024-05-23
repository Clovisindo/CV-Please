extends Control

class_name Curriculum

signal skill_selected(skill)

export(PackedScene) onready var skill_panel_scene
export(PackedScene) onready var timeline_work_scene

var cv_skill_class = load("res://scenes/game/items/curriculum/skill_panel.gd")


func set_name_applicant(applicant_name):
	if applicant_name:
		$CVPanel/CVVBoxContainer/HeaderApplicantPanelContainer/HeaderApplicantPanel/HeaderApplicantRichTextLabel.text = applicant_name


func add_skills(skills: Array):
	if skills:
		for skill in skills:
			var skill_panel = skill_panel_scene.instance()
			skill_panel.cv = self
			skill_panel.add_data(skill.textUI, skill.question, skill.answer)
			$CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.add_child(skill_panel)


func add_timeline_works(timeline_works: Array):
	if timeline_works:
		for timeline_work in timeline_works:
			var timeline_panel = timeline_work_scene.instance()
			timeline_panel.add_data(timeline_work.jobDescription, timeline_work.timejob)
			$CVPanel/CVVBoxContainer/TimeLineJobsPanelContainer/TimeLineJobsVBoxContainer.add_child(
				timeline_panel
			)


func set_min_salary(salary):
	if salary:
		$CVPanel/CVVBoxContainer/MinSalaryAmountJobPanel/MinSalaryTextLabel.text = (
			String(salary)
			+ "K"
		)


func wired_events(target_manager):
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			skill.connect("send_cross_question", target_manager, "execute_cross_question")


func idle_other_skills(selected_skill):
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			if skill != selected_skill:
				skill.skill_idle()


func idle_skills():
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			skill.skill_idle()


func disable_skills():
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			skill.skill_disable()


func enable_skills():
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			skill.skill_enable()


func previous_state_skills():
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			skill.skill_as_previous_state()


func enable_cross_skills():
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			skill.skill_cross_idle()


func disable_other_cross_skills(selected_skill):
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			if skill != selected_skill:
				skill.skill_disable()


func disable_cross_skills():
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			skill.skill_idle()


func save_previous_state():
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			skill.save_previous_state()


func skill_checked(skill):
	emit_signal("skill_selected", skill)
	$StateMachine.current_state.process_skill_selected(skill)


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func get_cross_skill():
	for skill in $CVPanel/CVVBoxContainer/SkillPanelContainer/SkillsVBoxContainer.get_children():
		if skill is cv_skill_class:
			if skill.check_is_status_cross_progress(skill.current_status):
				disable_other_cross_skills(skill)
				return skill


func process_cv(result):
	$StateMachine.current_state.process_cv(result)


func get_status():
	return $StateMachine.current_state

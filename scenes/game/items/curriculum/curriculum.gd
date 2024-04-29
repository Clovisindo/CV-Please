extends Control

class_name Curriculum

signal skill_selected(skill)

export(PackedScene) onready var skill_panel_scene


func add_skills(skills: Array):
	if skills:
		for skill in skills:
			var skill_panel = skill_panel_scene.instance()
			skill_panel.cv = self
			skill_panel.add_data(skill.textUI, skill.question, skill.answer)
			$CVPanel/VBoxContainer.add_child(skill_panel)


func idle_other_skills(selected_skill):
	for skill in $CVPanel/VBoxContainer.get_children():
		if skill != selected_skill:
			skill.skill_idle()


func skill_checked(skill):
	emit_signal("skill_selected", skill)
	$StateMachine.current_state.process_skill_selected(skill)


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func process_cv(result):
	$StateMachine.current_state.process_cv(result)


func get_status():
	return $StateMachine.current_state

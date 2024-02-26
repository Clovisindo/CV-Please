extends Control

class_name Curriculum

export(PackedScene) onready var skill_panel_scene

signal skill_selected(skill)


func add_skills(skills: Dictionary):
	if skills:
		for skill in skills:
			var skill_panel = skill_panel_scene.instance()
			skill_panel.cv = self
			var value = skills[skill].split('|')
			skill_panel.add_data(skill, value[0], value[1])
			$CVPanel/VBoxContainer.add_child(skill_panel)


func _skill_checked(skill):
	emit_signal("skill_selected", skill)
	$StateMachine.current_state.process_skill_selected(skill)


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func process_cv(result):
	$StateMachine.current_state.process_cv(result)


func get_status():
	return $StateMachine.current_state

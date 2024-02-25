extends Control

class_name Curriculum

export(PackedScene) onready var skill_panel_scene


func add_skills(skills: Dictionary):
	if skills:
		for skill in skills:
			var skill_panel = skill_panel_scene.instance()
			skill_panel.cv = self
			skill_panel.add_data(skill, "Answer")
			$CVPanel/VBoxContainer.add_child(skill_panel)


func _skill_checked(skill):
	$StateMachine.current_state.process_skill_selected(skill)


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func process_cv(result):
	$StateMachine.current_state.process_cv(result)


func get_status():
	return $StateMachine.current_state

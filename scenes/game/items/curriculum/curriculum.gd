extends Control

class_name Curriculum

export(PackedScene) var skill_scene

onready var state_machine = $StateMachine

func _ready():
	var skill_container = get_node("CVPanel/VBoxContainer")
	_instance_new_skill_line("skill 1","answer 1",skill_container)
	_instance_new_skill_line("skill 2","answer 2",skill_container)
	_instance_new_skill_line("skill 3","answer 3",skill_container)

func _instance_new_skill_line(skill_name, skill_answer, container):
	var skill_panel = skill_scene.instance()
	skill_panel.initialize(self, skill_name, skill_answer)
	container.add_child(skill_panel)

func skill_checked(skill):
	$StateMachine.current_state.process_skill_selected(skill)

func _gui_input(event):
	state_machine.current_state.handle_input(event)

func process_cv(result):
	$StateMachine.current_state.process_cv(result)

extends Control

class_name Curriculum

export(PackedScene) var skillScene

onready var state_machine = $StateMachine

func _ready():
	var skill_container = get_node("CVPanel/VBoxContainer")
	instance_new_skill_line("skill 1","answer 1",skill_container)
	instance_new_skill_line("skill 2","answer 2",skill_container)
	instance_new_skill_line("skill 3","answer 3",skill_container)

func instance_new_skill_line(skill_name, skill_answer, container):
	var skillPanel = skillScene.instance()
	skillPanel.initialize(self, skill_name, skill_answer)
	container.add_child(skillPanel)

func skill_checked(skill):
	print(skill)

func _gui_input(event):
	state_machine.current_state.handle_input(event)

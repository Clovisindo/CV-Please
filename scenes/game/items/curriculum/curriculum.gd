extends Control

export(PackedScene) var skillScene

var mouse_over = false
var event_fired = false
var skill_string_1 = "skill 1 loaded"
var skill_string_2 = "skill 2 loaded"

func _init():
	print("Init")

func _ready():
	var CVPanel = get_node("CVPanel/VBoxContainer")
	instance_new_skill_line("skill 1","asnwer 1",CVPanel)
	instance_new_skill_line("skill 2","asnwer 2",CVPanel)
	instance_new_skill_line("skill 3","asnwer 3",CVPanel)

func _on_Panel_gui_input(event,skill_answer):
	if event is InputEventMouseButton:
		if mouse_over == true && event_fired == false:
			print(skill_answer)
			event_fired = true

func instance_new_skill_line(skill_name, skill_answer, CVPanel):
	var skillPanel = skillScene.instance()
	skillPanel.skill_text = skill_name
	skillPanel.skill_answer = skill_answer
	skillPanel.get_node("SkillText").text = skillPanel.skill_text
	CVPanel.add_child(skillPanel)
	skillPanel._instantiate_connect(get_node("."))
	

func _on_Panel_mouse_entered():
	mouse_over = true

func _on_Panel_mouse_exited():
	mouse_over = false
	event_fired = false

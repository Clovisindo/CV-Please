extends Control

export(PackedScene) var skill_Scene

var MouseOver = false
var eventFired = false
var skill_string_1 = "skill 1 loaded"
var skill_string_2 = "skill 2 loaded"

func _init():
	print("Init")

func _ready():
	var CVPanel = get_node("CVPanel/VBoxContainer")
	instanceNewSkillLine("skill 1","asnwer 1",CVPanel)
	instanceNewSkillLine("skill 2","asnwer 2",CVPanel)
	instanceNewSkillLine("skill 3","asnwer 3",CVPanel)


func _on_Panel_gui_input(event):
	if event is InputEventMouseButton:
		if MouseOver == true && eventFired == false:
			print("Answer 1")
			eventFired = true

func instanceNewSkillLine(skill_name, skill_answer, CVPanel):
	var skillPanel = skill_Scene.instance()
	skillPanel.skill_text = skill_name
	skillPanel.skill_answer = skill_answer
	skillPanel.get_node("SkillText").text = skillPanel.skill_text
	CVPanel.add_child(skillPanel)
	

func _on_Panel_mouse_entered():
	MouseOver = true

func _on_Panel_mouse_exited():
	MouseOver = false
	eventFired = false

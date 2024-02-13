extends Control

export(PackedScene) var requisiteScene

var mouse_over = false
var event_fired = false
var requisite_string_1 = "requisite 1 loaded"
var requisite_string_2 = "requisite 2 loaded"

func _init():
	print("Init")

func _ready():
	var jobOfferPanel = get_node("JobOfferPanel/VBoxContainer")
	instance_new_requisite_line("requisite 1","asnwer 1",jobOfferPanel)
	instance_new_requisite_line("requisite 2","asnwer 2",jobOfferPanel)
	instance_new_requisite_line("requisite 3","asnwer 3",jobOfferPanel)


func _on_job_requisite_panel_gui_input(event,requisite_answer):
	if event is InputEventMouseButton:
		if mouse_over == true && event_fired == false:
			print(requisite_answer)
			event_fired = true

func instance_new_requisite_line(requisite_name, requisite_answer, jobOfferPanel):
	var requisitePanel = requisiteScene.instance()
	requisitePanel.requisite_text = requisite_name
	requisitePanel.requisite_answer = requisite_answer
	requisitePanel.get_node("RequisiteText").text = requisitePanel.requisite_text
	jobOfferPanel.add_child(requisitePanel)
	requisitePanel._instantiate_signal_job_requisite(get_node("."))
	

func _on_panel_mouse_entered():
	mouse_over = true

func _on_panel_mouse_exited():
	mouse_over = false
	event_fired = false

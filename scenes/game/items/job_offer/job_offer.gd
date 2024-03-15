extends Control

class_name JobOffer

export(PackedScene) onready var requisite_scene

signal job_requisite_selected(job_requisite)

func add_requisites(requisites: Array):
	if requisites:
		for requisite in requisites:
			var requisite_panel = requisite_scene.instance()
			requisite_panel.job_offer = self
			requisite_panel.add_data(requisite.textUI, requisite.question, requisite.answer)
			$JobOfferPanel/VBoxContainer.add_child(requisite_panel)


func idle_other_requisites(selected_requisite):
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite != selected_requisite:
			requisite.requisite_idle()

func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func _requisite_checked(requisite):
	emit_signal("job_requisite_selected", requisite)

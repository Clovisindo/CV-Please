extends Control

class_name JobOffer

export(PackedScene) onready var requisite_scene

signal job_requisite_selected(job_requisite)

func add_requisites(requisites: Dictionary):
	if requisites:
		for requisite in requisites:
			var requisite_panel = requisite_scene.instance()
			requisite_panel.job_offer = self
			var value = requisites[requisite].split('|')
			requisite_panel.add_data(requisite, value[0], value[1])
			$JobOfferPanel/VBoxContainer.add_child(requisite_panel)


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func _requisite_checked(requisite):
	emit_signal("job_requisite_selected", requisite)

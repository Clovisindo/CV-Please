extends Control

class_name JobOffer

signal job_requisite_selected(job_requisite)

export(PackedScene) onready var requisite_scene


func add_requisites(requisites: Array):
	if requisites:
		for requisite in requisites:
			var requisite_panel = requisite_scene.instance()
			requisite_panel.job_offer = self
			requisite_panel.add_data(requisite.textUI, requisite.question, requisite.answer)
			$JobOfferPanel/VBoxContainer.add_child(requisite_panel)


func wired_events(target_manager):
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		requisite.connect("send_cross_question", target_manager, "execute_cross_question")


func idle_other_requisites(selected_requisite):
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite != selected_requisite:
			requisite.requisite_idle()


func idle_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		requisite.requisite_idle()


func disable_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		requisite.requisite_disable()


func enable_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		requisite.requisite_enable()


func enable_cross_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		requisite.requisite_cross_idle()


func disable_other_cross_requisites(selected_requisite):
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite != selected_requisite:
			requisite.requisite_disable()


func disable_cross_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		requisite.requisite_idle()


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func get_cross_requisite():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite.check_is_status_cross_progress(requisite.current_status):
			disable_other_cross_requisites(requisite)
			return requisite


func requisite_checked(requisite):
	emit_signal("job_requisite_selected", requisite)
